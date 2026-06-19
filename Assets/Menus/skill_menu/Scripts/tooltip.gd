extends Control

@onready var bg: NinePatchRect = $Background
@onready var icon: TextureRect = $Icon
@onready var skill_name: Label = $SkillName
@onready var skill_desc: Label = $SkillDesc

func show_for(s: SkillData, anchor: Vector2) -> void:
	icon.texture = s.icon
	skill_name.text = s.name.to_upper()
	skill_desc.text = s.description
	show()
	await get_tree().process_frame
	global_position = Vector2(
		anchor.x - size.x / 2.0,
		anchor.y - size.y - 8.0
	)

func hide_tooltip() -> void:
	hide()
