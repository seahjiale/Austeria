extends Control

@onready var skill_grid: GridContainer = $LeftPage/SkillGrid
@onready var equip_grid: GridContainer = $RightPage/EquipGrid
@onready var tooltip = $Tooltip
@onready var anim: AnimatedSprite2D = $BookSprite
@onready var points_label: Label = $LeftPage/PointsLabel
@onready var unlock_button: Button = $LeftPage/UnlockButton

# State
var all_skills: Array = []
var _dragged_skill: SkillData = null
var _drag_origin: TextureRect = null
var _selected_locked_skill: SkillData = null


# SETUP 
func _ready() -> void:
	hide()
	$LeftPage.hide()
	$RightPage.hide()
	tooltip.hide()
	unlock_button.hide()
	unlock_button.pressed.connect(_on_unlock_pressed)

	_load_skills()
	_build_skill_grid()
	_setup_equip_slots()
	_update_points_label()

	SkillManager.points_changed.connect(_on_points_changed)
	SkillManager.skill_unlocked.connect(_on_skill_unlocked)


func _load_skills() -> void:
	all_skills.append(preload("res://Assets/Menus/skill_menu/skills/rock_spike/rock_spike.tres"))
	all_skills.append(preload("res://Assets/Menus/skill_menu/skills/laser_beam/laser_beam.tres"))
	all_skills.append(preload("res://Assets/Menus/skill_menu/skills/shadow_walker/shadow_walker.tres"))


# INPUT — book open/close + click to dismiss
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("open_skill_book"):
		_toggle_book()
		return

	# click away to dismiss the unlock button
	if unlock_button.visible and event is InputEventMouseButton \
			and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var mouse_pos = get_global_mouse_position()
		var button_rect = Rect2(unlock_button.global_position, unlock_button.size)
		if not button_rect.has_point(mouse_pos):
			_hide_unlock_button()


func _toggle_book() -> void:
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


# SKILL POINTS / UNLOCKING
func _update_points_label() -> void:
	points_label.text = "Skill Points: " + str(SkillManager.skill_points)


func _on_points_changed(_new_total: int) -> void:
	_update_points_label()


func _on_skill_unlocked(_skill: SkillData) -> void:
	_build_skill_grid()
	_hide_unlock_button()


func _on_locked_skill_clicked(event: InputEvent, skill: SkillData, slot: TextureRect) -> void:
	if not (event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT):
		return
	_selected_locked_skill = skill
	unlock_button.text = "Unlock " + skill.name + " (1 pt)"
	unlock_button.show()
	await get_tree().process_frame
	unlock_button.global_position = Vector2(
		slot.global_position.x + slot.size.x / 2.0 - unlock_button.size.x / 2.0,
		slot.global_position.y - unlock_button.size.y - 8.0
	)


func _on_unlock_pressed() -> void:
	if _selected_locked_skill == null:
		return
	var success = SkillManager.try_unlock_skill(_selected_locked_skill)
	if success:
		return
	unlock_button.text = "Not enough points!"
	await get_tree().create_timer(1.0).timeout
	if _selected_locked_skill:
		unlock_button.text = "Unlock " + _selected_locked_skill.name + " (1 pt)"


func _hide_unlock_button() -> void:
	unlock_button.hide()
	_selected_locked_skill = null


# LEFT PAGE
func _build_skill_grid() -> void:
	for child in skill_grid.get_children():
		child.queue_free()

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

		if SkillManager.is_unlocked(skill):
			slot.modulate = Color(1, 1, 1, 1)
			slot.set_drag_forwarding(
				_get_skill_drag_data.bind(slot),
				_can_drop_on_skill.bind(slot),
				_drop_on_skill.bind(slot)
			)
		else:
			slot.modulate = Color(0.4, 0.4, 0.4, 1)
			slot.gui_input.connect(_on_locked_skill_clicked.bind(skill, slot))

		skill_grid.add_child(slot)


func _get_skill_drag_data(_at_position: Vector2, slot: TextureRect) -> Variant:
	var preview := TextureRect.new()
	preview.texture = slot.get_meta("skill").icon
	preview.custom_minimum_size = Vector2(48, 48)
	preview.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	preview.modulate.a = 0.8
	set_drag_preview(preview)
	return slot.get_meta("skill")


func _can_drop_on_skill(_at_position: Vector2, _data: Variant, _slot: TextureRect) -> bool:
	return false


func _drop_on_skill(_at_position: Vector2, _data: Variant, _slot: TextureRect) -> void:
	pass


# RIGHT PAGE
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
		slot.set_meta("is_filled", false)
		slot.set_meta("equipped_skill", null)
		slot.set_drag_forwarding(
			_get_equip_drag_data.bind(slot),
			_can_drop_on_equip.bind(slot),
			_drop_on_equip.bind(slot)
		)


func _get_equip_drag_data(_at_position: Vector2, slot: TextureRect) -> Variant:
	if not slot.get_meta("is_filled", false):
		return null
	var skill = slot.get_meta("equipped_skill")
	var preview := TextureRect.new()
	preview.texture = skill.icon
	preview.custom_minimum_size = Vector2(48, 48)
	preview.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	preview.modulate.a = 0.8
	set_drag_preview(preview)
	_drag_origin = slot
	return skill


func _can_drop_on_equip(_at_position: Vector2, data: Variant, slot: TextureRect) -> bool:
	return data is SkillData and not slot.get_meta("is_filled", false)


func _drop_on_equip(_at_position: Variant, data: Variant, slot: TextureRect) -> void:
	if not slot.has_meta("index"):
		return
	if _drag_origin and _drag_origin != slot:
		_unequip_slot(_drag_origin)
	_drag_origin = null
	_equip_skill_to_slot(data, slot)
	SkillManager.equip_skill(slot.get_meta("index"), data)


func _equip_skill_to_slot(skill: SkillData, slot: TextureRect) -> void:
	slot.set_meta("is_filled", true)
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


func _unequip_slot(slot: TextureRect) -> void:
	slot.set_meta("is_filled", false)
	slot.set_meta("equipped_skill", null)
	for child in slot.get_children():
		child.queue_free()
	SkillManager.unequip_skill(slot.get_meta("index"))


func _notification(what: int) -> void:
	if what == NOTIFICATION_DRAG_END:
		if _drag_origin and not get_viewport().gui_is_drag_successful():
			_unequip_slot(_drag_origin)
		_drag_origin = null



# TOOLTIP (hover)
func _on_slot_hovered(slot: TextureRect) -> void:
	if _dragged_skill:
		return
	var skill = slot.get_meta("skill")
	var anchor = slot.global_position + Vector2(slot.size.x / 2.0, 0)
	tooltip.show_for(skill, anchor)


func _on_slot_unhovered() -> void:
	tooltip.hide_tooltip()
