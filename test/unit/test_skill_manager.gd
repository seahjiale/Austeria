extends GutTest

var SkillManagerScript = preload("res://Assets/Menus/skill_menu/skill_manager.gd")
var sm

func before_each():
	sm = SkillManagerScript.new()
	add_child(sm)

func after_each():
	sm.free()

func _make_skill(id: String, cooldown: float) -> SkillData:
	var skill = SkillData.new()
	skill.id = id
	skill.cooldown = cooldown
	return skill

# --- Equip slots ------------------------------------------------------

func test_equip_skill_fills_slot():
	var skill = _make_skill("rock_spike", 2.0)
	sm.equip_skill(0, skill)
	assert_eq(sm.get_skill(0), skill, "Slot 0 should hold the equipped skill")

func test_unequip_skill_clears_slot():
	var skill = _make_skill("rock_spike", 2.0)
	sm.equip_skill(0, skill)
	sm.unequip_skill(0)
	assert_null(sm.get_skill(0), "Slot should be empty after unequip")

func test_equip_skill_emits_signal():
	watch_signals(sm)
	var skill = _make_skill("rock_spike", 2.0)
	sm.equip_skill(1, skill)
	assert_signal_emitted_with_parameters(sm, "skill_equipped", [1, skill])

# --- Skill points / unlocking -------------------------------------------------

func test_add_skill_point_increases_total():
	sm.add_skill_point(1)
	assert_eq(sm.skill_points, 1, "Should have 1 skill point")

func test_add_skill_point_default_amount_is_one():
	sm.add_skill_point()
	assert_eq(sm.skill_points, 1, "Default amount should add exactly 1")

func test_try_unlock_skill_fails_with_no_points():
	var skill = _make_skill("god_fist", 5.0)
	var result = sm.try_unlock_skill(skill)
	assert_false(result, "Should fail to unlock with 0 skill points")
	assert_false(sm.is_unlocked(skill), "Skill should not be unlocked")

func test_try_unlock_skill_succeeds_with_points():
	sm.add_skill_point(1)
	var skill = _make_skill("god_fist", 5.0)
	var result = sm.try_unlock_skill(skill)
	assert_true(result, "Should succeed with enough points")
	assert_true(sm.is_unlocked(skill), "Skill should now be unlocked")
	assert_eq(sm.skill_points, 0, "Should spend exactly 1 point")

func test_try_unlock_skill_fails_if_already_unlocked():
	sm.add_skill_point(2)
	var skill = _make_skill("god_fist", 5.0)
	sm.try_unlock_skill(skill)
	var second_attempt = sm.try_unlock_skill(skill)
	assert_false(second_attempt, "Should not unlock the same skill twice")
	assert_eq(sm.skill_points, 1, "Second attempt should not spend a point")

# --- Cooldowns / use_skill -----------------------------------------------

func test_use_skill_does_nothing_with_no_equipped_skill():
	watch_signals(sm)
	sm.use_skill(0)
	assert_signal_not_emitted(sm, "skill_used")

func test_use_skill_starts_cooldown():
	var skill = _make_skill("shadow_orb", 3.0)
	sm.equip_skill(0, skill)
	sm.use_skill(0)
	assert_eq(sm._cooldowns[0], 3.0, "Cooldown should be set to the skill's cooldown value")

func test_use_skill_blocked_while_on_cooldown():
	var skill = _make_skill("shadow_orb", 3.0)
	sm.equip_skill(0, skill)
	sm.use_skill(0)
	watch_signals(sm)
	sm.use_skill(0)
	assert_signal_not_emitted(sm, "skill_used", "Should not re-trigger while on cooldown")

func test_cooldown_decreases_over_time():
	var skill = _make_skill("shadow_orb", 3.0)
	sm.equip_skill(0, skill)
	sm.use_skill(0)
	sm._process(1.0)
	assert_almost_eq(sm._cooldowns[0], 2.0, 0.01, "Cooldown should decrease by delta")

func test_cooldown_does_not_go_negative():
	var skill = _make_skill("shadow_orb", 1.0)
	sm.equip_skill(0, skill)
	sm.use_skill(0)
	sm._process(5.0)
	assert_eq(sm._cooldowns[0], 0.0, "Cooldown should clamp at 0, not go negative")

func test_skill_usable_again_after_cooldown_expires():
	var skill = _make_skill("shadow_orb", 1.0)
	sm.equip_skill(0, skill)
	sm.use_skill(0)
	sm._process(1.0)
	watch_signals(sm)
	sm.use_skill(0)
	assert_signal_emitted(sm, "skill_used", "Should be usable again once cooldown hits 0")
