extends GutTest

var ExpManagerScript = preload("res://Assets/Game/exp_manager.gd")
var exp_manager

func before_each():
	exp_manager = ExpManagerScript.new()
	add_child(exp_manager)
	exp_manager._ready()

func after_each():
	exp_manager.free()

func test_starts_at_level_1_with_zero_xp():
	assert_eq(exp_manager.level, 1, "Should start at level 1")
	assert_eq(exp_manager.current_xp, 0, "Should start with 0 XP")

func test_gain_xp_without_leveling_up():
	exp_manager.gain_xp(50)
	assert_eq(exp_manager.current_xp, 50, "Should accumulate XP")
	assert_eq(exp_manager.level, 1, "Should not level up yet (needs 100)")

func test_gain_xp_triggers_level_up():
	watch_signals(exp_manager)
	exp_manager.gain_xp(100)
	assert_eq(exp_manager.level, 2, "Should level up to 2")
	assert_eq(exp_manager.current_xp, 0, "Overflow XP should be consumed exactly")
	assert_signal_emitted(exp_manager, "level_changed")

func test_gain_xp_carries_over_excess():
	exp_manager.gain_xp(120)
	assert_eq(exp_manager.level, 2, "Should level up once")
	assert_eq(exp_manager.current_xp, 20, "Leftover XP should carry into new level")

func test_gain_xp_can_trigger_multiple_level_ups():
	exp_manager.gain_xp(1000)
	assert_gt(exp_manager.level, 2, "Should be able to level up multiple times in one gain_xp call")

func test_get_xp_percent():
	exp_manager.gain_xp(50)
	assert_almost_eq(exp_manager.get_xp_percent(), 0.5, 0.01, "50/100 XP should be 50%")

func test_reset_returns_to_level_1():
	exp_manager.gain_xp(250)
	exp_manager.reset()
	assert_eq(exp_manager.level, 1, "Reset should return to level 1")
	assert_eq(exp_manager.current_xp, 0, "Reset should zero out XP")
