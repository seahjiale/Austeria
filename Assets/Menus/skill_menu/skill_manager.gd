extends Node

var equipped_slots: Array = [null, null, null, null]

signal skill_equipped(slot_index: int, skill: SkillData)
signal skill_unequipped(slot_index: int)

func equip_skill(slot_index: int, skill: SkillData) -> void:
	equipped_slots[slot_index] = skill
	skill_equipped.emit(slot_index, skill)

func unequip_skill(slot_index: int) -> void:
	equipped_slots[slot_index] = null
	skill_unequipped.emit(slot_index)

func get_skill(slot_index: int) -> SkillData:
	return equipped_slots[slot_index]
