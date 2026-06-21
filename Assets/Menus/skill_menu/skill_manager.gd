extends Node

var equipped_slots: Array = [null, null, null, null]

signal skill_equipped(slot_index: int, skill: SkillData)
signal skill_unequipped(slot_index: int)

func _ready() -> void:
	ExpManager.level_changed.connect(_on_level_up)

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
