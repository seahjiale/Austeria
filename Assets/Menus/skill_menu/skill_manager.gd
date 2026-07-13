extends Node

var equipped_slots: Array = [null, null, null, null]

signal skill_equipped(slot_index: int, skill: SkillData)
signal skill_unequipped(slot_index: int)
signal manager_reset

func _ready() -> void:
	ExpManager.level_changed.connect(_on_level_up)
	
func reset() -> void:
	equipped_slots = [null, null, null, null]
	skill_points = 0
	unlocked_skills.clear()
	_cooldowns = [0.0, 0.0, 0.0, 0.0]
	_max_cooldowns = [0.0, 0.0, 0.0, 0.0]
	manager_reset.emit()

func _on_level_up(_new_level: int) -> void:
	add_skill_point(1)

func equip_skill(slot_index: int, skill: SkillData) -> void:
	equipped_slots[slot_index] = skill
	skill_equipped.emit(slot_index, skill)

func unequip_skill(slot_index: int) -> void:
	equipped_slots[slot_index] = null
	skill_unequipped.emit(slot_index)

func get_skill(slot_index: int) -> SkillData:
	return equipped_slots[slot_index]

var skill_points: int = 0
var unlocked_skills: Array = []  # array of skill ids (Strings)

signal points_changed(new_total: int)
signal skill_unlocked(skill: SkillData)

func add_skill_point(amount: int = 1) -> void:
	skill_points += amount
	points_changed.emit(skill_points)

func is_unlocked(skill: SkillData) -> bool:
	return skill.id in unlocked_skills

func try_unlock_skill(skill: SkillData) -> bool:
	if is_unlocked(skill):
		return false
	if skill_points < 1:
		return false
	skill_points -= 1
	unlocked_skills.append(skill.id)
	points_changed.emit(skill_points)
	skill_unlocked.emit(skill)
	return true

signal skill_used(slot_index: int, cooldown: float)
signal cooldown_updated(slot_index: int, remaining: float)

var _cooldowns: Array[float] = [0.0, 0.0, 0.0, 0.0]
var _max_cooldowns: Array[float] = [0.0, 0.0, 0.0, 0.0]

func use_skill(slot_index: int) -> void:
	var skill = equipped_slots[slot_index]
	if skill == null or _cooldowns[slot_index] > 0.0:
		return
	_max_cooldowns[slot_index] = skill.cooldown
	_cooldowns[slot_index] = skill.cooldown
	skill_used.emit(slot_index, skill.cooldown)
	# TODO: your actual skill firing logic here

func _process(delta: float) -> void:
	for i in _cooldowns.size():
		if _cooldowns[i] > 0.0:
			_cooldowns[i] = maxf(0.0, _cooldowns[i] - delta)
			cooldown_updated.emit(i, _cooldowns[i])
