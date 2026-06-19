extends Control

@onready var skill_grid: GridContainer = $LeftPage/SkillGrid
@onready var equip_grid: GridContainer = $RightPage/EquipGrid
@onready var tooltip = $Tooltip
@onready var anim: AnimatedSprite2D = $BookSprite

const MAX_EQUIP_SLOTS := 6

var all_skills: Array = []

func _ready() -> void:
	hide()
	tooltip.hide()
	$LeftPage.hide()
	$RightPage.hide()
	_load_skills()
	_build_skill_grid()

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

func _on_slot_hovered(slot: TextureRect) -> void:
	var skill = slot.get_meta("skill")
	var anchor = slot.global_position + Vector2(slot.size.x / 2.0, 0)
	$Tooltip.show_for(skill, anchor)

func _on_slot_unhovered() -> void:
	$Tooltip.hide_tooltip()

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
