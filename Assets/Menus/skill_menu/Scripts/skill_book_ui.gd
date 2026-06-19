extends Control

@onready var skill_grid: GridContainer = $LeftPage/SkillGrid
@onready var equip_grid: GridContainer = $RightPage/EquipGrid
@onready var tooltip = $Tooltip
@onready var anim: AnimatedSprite2D = $BookSprite

var all_skills: Array = []
var _dragged_skill: SkillData = null
var _drag_origin: TextureRect = null

func _ready() -> void:
	hide()
	$LeftPage.hide()
	$RightPage.hide()
	tooltip.hide()
	_load_skills()
	_build_skill_grid()
	_setup_equip_slots()

func _load_skills() -> void:
	all_skills.append(preload("res://Assets/Menus/skill_menu/skills/rock_spike.tres"))

func _build_skill_grid() -> void:
	skill_grid.columns = 3
	skill_grid.add_theme_constant_override("h_separation", 8)
	skill_grid.add_theme_constant_override("v_separation", 8)
	for skill in all_skills:
		var slot := TextureRect.new()
		slot.texture = skill.icon
		slot.custom_minimum_size = Vector2(64, 64)
		slot.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		slot.mouse_filter = Control.MOUSE_FILTER_STOP
		slot.set_meta("skill", skill)
		slot.mouse_entered.connect(_on_slot_hovered.bind(slot))
		slot.mouse_exited.connect(_on_slot_unhovered)
		skill_grid.add_child(slot)
		slot.set_drag_forwarding(
			_get_skill_drag_data.bind(slot),
			_can_drop_on_skill.bind(slot),
			_drop_on_skill.bind(slot)
		)

func _get_skill_drag_data(_at_position: Vector2, slot: TextureRect) -> Variant:
	var preview := TextureRect.new()
	preview.texture = slot.get_meta("skill").icon
	preview.custom_minimum_size = Vector2(48, 48)
	preview.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	preview.modulate.a = 0.8
	set_drag_preview(preview)
	return slot.get_meta("skill")

func _can_drop_on_skill(at_position: Vector2, _data: Variant, _slot: TextureRect) -> bool:
	return false

func _drop_on_skill(at_position: Vector2, _data: Variant, _slot: TextureRect) -> void:
	pass

func _setup_equip_slots() -> void:
	var slots = [
		$RightPage/EquipGrid/Slot1,
		$RightPage/EquipGrid/Slot2,
		$RightPage/EquipGrid/Slot3,
		$RightPage/EquipGrid/Slot4
	]
	for i in slots.size():
		var slot = slots[i]
		slot.mouse_filter = Control.MOUSE_FILTER_STOP
		slot.set_meta("index", i)
		slot.set_meta("equipped_skill", null)
		slot.set_drag_forwarding(
			func(_pos, _s): return null,
			_can_drop_on_equip.bind(slot),
			_drop_on_equip.bind(slot)
		)

func _can_drop_on_equip(at_position: Vector2, data: Variant, slot: TextureRect) -> bool:
	return data is SkillData

func _drop_on_equip(at_position: Vector2, data: Variant, slot: TextureRect) -> void:
	_equip_skill_to_slot(data, slot)

func _equip_skill_to_slot(skill: SkillData, slot: TextureRect) -> void:
	if not slot.has_meta("original_texture"):
		slot.set_meta("original_texture", slot.texture)
	slot.set_meta("equipped_skill", skill)
	for child in slot.get_children():
		child.queue_free()
	var icon := TextureRect.new()
	icon.texture = skill.icon
	icon.custom_minimum_size = Vector2(38, 38)
	icon.size = Vector2(38, 38)
	icon.position = Vector2(21, 18)
	icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	icon.mouse_filter = Control.MOUSE_FILTER_IGNORE
	slot.add_child(icon)

func _on_slot_hovered(slot: TextureRect) -> void:
	if _dragged_skill:
		return
	var skill = slot.get_meta("skill")
	var anchor = slot.global_position + Vector2(slot.size.x / 2.0, 0)
	tooltip.show_for(skill, anchor)

func _on_slot_unhovered() -> void:
	tooltip.hide_tooltip()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("open_skill_book"):
		if visible:
			$LeftPage.hide()
			$RightPage.hide()
			anim.play("close")
			await anim.animation_finished
			hide()
		else:
			show()
			anim.play("open")
			await anim.animation_finished
			anim.play("idle")
			$LeftPage.show()
			$RightPage.show()
