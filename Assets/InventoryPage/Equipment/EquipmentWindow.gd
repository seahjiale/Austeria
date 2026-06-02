extends Control

@export var equipment_data: EquipmentData

@onready var weapon_texture: TextureRect = %WeaponTexture
@onready var weapon_name: Label = %WeaponName

func _ready() -> void:
	visible = false
	GlobalSignals.update_equipment.connect(update_equipment_ui)
	update_equipment_ui()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Equipment"):
		visible = !visible

func update_equipment_ui() -> void:
	if equipment_data.equipped_weapon == null:
		weapon_texture.texture = null
		weapon_name.text = "No weapon"
		return

	weapon_texture.texture = equipment_data.equipped_weapon.item_texture
	weapon_name.text = equipment_data.equipped_weapon.item_name
