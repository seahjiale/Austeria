extends Control

@export var inventory_data : InventoryData
var current_dragged_item_data : Dictionary = {}
var slot_scene = preload("res://Assets/InventoryPage/Inventory/Slot.tscn")

func _process(_delta: float) -> void:
	if not has_node("ItemDrag"):
		return
	$ItemDrag.global_position = get_global_mouse_position()

func _ready() -> void:
	visible = false
	print("saved inventory on load: ", GameState.saved_inventory)
	if GameState.saved_inventory.size() > 0:
		inventory_data.item_data.clear()
		for path in GameState.saved_inventory:
			if path != "":
				inventory_data.item_data.append(load(path))
			else:
				inventory_data.item_data.append(null)
		GameState.saved_inventory.clear()
	update_inventory_data()
	connect_signals()

func connect_signals() -> void:
	GlobalSignals.update_inventory.connect(update_inventory_data)

func update_inventory_data() -> void:
	for slot in %SlotGroup.get_children():
		slot.queue_free()
	await get_tree().process_frame
	
	for item_data in inventory_data.item_data:
		var new_slot = slot_scene.instantiate()
		new_slot.current_item = item_data
		%SlotGroup.add_child(new_slot)
		

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("inventory"):
		visible = !visible
		return
	if not visible:
		return
		
	if event.is_action_pressed("drag_items"):
		start_drag()
		
	if event.is_action_released("drag_items"):
		end_drag()
		

func start_drag() -> void:
	if not current_dragged_item_data.is_empty():
		return

	var hovered_slot = get_hovered_slot()
	var hovered_equipment_slot = get_hovered_equipment_slot()

	if hovered_slot != null:
		start_drag_from_inventory(hovered_slot)
		return

	if hovered_equipment_slot != null:
		start_drag_from_equipment(hovered_equipment_slot)
		return

func end_drag() -> void:
	var item = current_dragged_item_data.get("Item")
	var source = current_dragged_item_data.get("Source")
	var original_index = current_dragged_item_data.get("Index")

	if item == null:
		return

	var hovered_equipment_slot = get_hovered_equipment_slot()
	var hovered_slot = get_hovered_slot()

	if hovered_equipment_slot != null:
		# Only works if item is valid equipment, e.g. WeaponData.
		if hovered_equipment_slot.equip_item(item):
			finish_drag()
			return

		return_item_to_source(item, source, original_index)
		finish_drag()
		return

	if hovered_slot != null:
		var target_index = hovered_slot.get_index()

		if inventory_data.item_data[target_index] == null:
			inventory_data.item_data[target_index] = item
			finish_drag()
			return

		return_item_to_source(item, source, original_index)
		finish_drag()
		return

	return_item_to_source(item, source, original_index)
	finish_drag()

func return_item_to_source(item: ItemData, source: String, original_index: int) -> void:
	if source == "Inventory":
		inventory_data.item_data[original_index] = item
		return

	if source == "Equipment":
		var equipment_slot = get_tree().get_first_node_in_group("equipment_slot")

		if equipment_slot != null:
			equipment_slot.equip_item(item)
		else:
			print("No equipment slot found in group 'equipment_slot'.")

func start_drag_from_inventory(slot: Slot) -> void:
	var index = slot.get_index()
	if inventory_data.item_data[index] == null:
		return
	var item = inventory_data.item_data[index]

	current_dragged_item_data = {
		"Item": item,
		"Source": "Inventory",
		"Index": index
	}
	create_drag_item(item)
	inventory_data.item_data[index] = null
	GlobalSignals.update_inventory.emit()

func start_drag_from_equipment(equipment_slot: EquipmentSlot) -> void:
	if not equipment_slot.has_equipped_item():
		return

	var item = equipment_slot.get_equipped_item()

	current_dragged_item_data = {
		"Item": item,
		"Source": "Equipment",
		"Index": -1
	}

	create_drag_item(item)

	equipment_slot.remove_equipped_item()
	GlobalSignals.update_equipment.emit()


func finish_drag() -> void:
	delete_dragged_item()
	current_dragged_item_data.clear()
	GlobalSignals.update_inventory.emit()
	GlobalSignals.update_equipment.emit()

func delete_dragged_item() -> void:
	if has_node("ItemDrag"):
		$ItemDrag.queue_free()

func create_drag_item(item: ItemData) -> void:
	var new_drag_item: TextureRect = TextureRect.new()
	new_drag_item.texture = item.item_texture
	new_drag_item.mouse_filter = Control.MOUSE_FILTER_IGNORE
	new_drag_item.name = "ItemDrag"
	add_child(new_drag_item)

func get_hovered_equipment_slot() -> EquipmentSlot:
	var hovered_node = get_viewport().gui_get_hovered_control()

	if hovered_node == null:
		return null

	if hovered_node is EquipmentSlot:
		return hovered_node

	if hovered_node.get_parent() is EquipmentSlot:
		return hovered_node.get_parent()

	return null

func get_hovered_slot() -> Slot:
	var hovered_node = get_viewport().gui_get_hovered_control()

	if hovered_node == null:
		return null

	if hovered_node is Slot:
		return hovered_node

	if hovered_node.get_parent() is Slot:
		return hovered_node.get_parent()

	return null
