extends Panel
class_name EquipmentSlot

@export var equipment_data: EquipmentData

func can_equip(item: ItemData) -> bool:
	return item is WeaponData

func equip_item(item: ItemData) -> bool:
	if not can_equip(item):
		return false

	var weapon := item as WeaponData
	equipment_data.equipped_weapon = weapon

	var player = get_tree().get_first_node_in_group("player")
	if player != null:
		player.equip_weapon(weapon)
	else:
		print("No player found in group 'player'.")

	GlobalSignals.update_equipment.emit()
	return true

func has_equipped_item() -> bool:
	return equipment_data.equipped_weapon != null

func get_equipped_item() -> WeaponData:
	return equipment_data.equipped_weapon

func remove_equipped_item() -> void:
	equipment_data.equipped_weapon = null

	var player = get_tree().get_first_node_in_group("player")
	if player != null:
		player.equip_weapon(null)

	GlobalSignals.update_equipment.emit()
