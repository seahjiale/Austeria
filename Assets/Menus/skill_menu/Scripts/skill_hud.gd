extends Control

@onready var slots: Array = [
	$HBoxContainer/Slot0,
	$HBoxContainer/Slot1,
	$HBoxContainer/Slot2,
	$HBoxContainer/Slot3,
]

func _ready() -> void:
	for slot in slots:
		_init_slot(slot)
	SkillManager.skill_equipped.connect(_on_skill_equipped)
	SkillManager.skill_unequipped.connect(_on_skill_unequipped)
	SkillManager.cooldown_updated.connect(_on_cooldown_updated)


func _init_slot(slot: Control) -> void:
	var sweep = slot.get_node("CooldownSweep")
	sweep.min_value = 0.0
	sweep.max_value = 1.0
	sweep.value = 0.0
	slot.get_node("CooldownLabel").hide()

func _on_skill_equipped(slot_index: int, skill: SkillData) -> void:
	var slot = slots[slot_index]
	slot.get_node("SkillIcon").texture = skill.icon
	slot.get_node("SkillIcon").show()
	var sweep = slot.get_node("CooldownSweep")
	sweep.max_value = skill.cooldown
	sweep.value = 0.0

func _on_skill_unequipped(slot_index: int) -> void:
	var slot = slots[slot_index]
	slot.get_node("SkillIcon").texture = null
	slot.get_node("SkillIcon").hide()
	slot.get_node("CooldownSweep").value = 0.0
	slot.get_node("CooldownLabel").hide()

func _on_cooldown_updated(slot_index: int, remaining: float) -> void:
	var slot = slots[slot_index]
	var sweep = slot.get_node("CooldownSweep")
	var label = slot.get_node("CooldownLabel")

	if remaining > 0.0:
		sweep.value = remaining  # no division, just use remaining directly
		label.text = "%.1f" % remaining
		label.show()
	else:
		sweep.value = 0.0
		label.hide()
