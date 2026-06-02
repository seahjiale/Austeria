extends Control

@export var inventory_data : InventoryData
var current_dragged_item_data : Dictionary

func _process(_delta: float) -> void:
	if not has_node("ItemDrag"):
		return
	get_node("ItemDrag").position = get_global_mouse_position()

func _ready() -> void:
	visible = false
	update_inventory_data()
	connect_signals()

func connect_signals() -> void:
	GlobalSignals.update_inventory.connect(update_inventory_data)

func update_inventory_data() -> void:
	for slot in %SlotGroup.get_children():
		slot.queue_free()
	
	for item_data in inventory_data.item_data:
		var new_slot = preload("res://Assets/Items/Resources/Slot.tscn").instantiate()
		new_slot.current_item = item_data
		%SlotGroup.add_child(new_slot)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("inventory"):
		visible = !visible
		return
	if not visible:
		return
		
	if event.is_action_pressed("drag_items"):
		var hovered_node = get_viewport().gui_get_hovered_control()
		if hovered_node is Slot:
			var current_index = hovered_node.get_index()
			if not inventory_data.item_data[current_index]:
				return
			create_drag_item(current_index)
			inventory_data.item_data[current_index] = null
			GlobalSignals.update_inventory.emit()
		
	if event.is_action_released("drag_items"):
		var hovered_node = get_viewport().gui_get_hovered_control()
		var item = current_dragged_item_data.get("Item")
		var index = current_dragged_item_data.get("Index")
		
		if item == null:
			return
			
		if hovered_node is Slot:
			var target_index = hovered_node.get_index()
			
			# If target slot has item, return dragged item to original slot for now
			if inventory_data.item_data[target_index]:
				inventory_data.item_data[index] = item
			else:
				inventory_data.item_data[target_index] = item
		else:
			# Dropped outside slot, return to original slot
			inventory_data.item_data[index] = item
			
		delete_dragged_item()
		current_dragged_item_data.clear()
		GlobalSignals.update_inventory.emit()

func delete_dragged_item() -> void:
	get_node("ItemDrag").queue_free()

func create_drag_item(Index : int) -> void:
	current_dragged_item_data = {"Item" : inventory_data.item_data[Index], "Index" : Index}
	var new_drag_item : TextureRect = TextureRect.new()
	new_drag_item.texture = inventory_data.item_data[Index].item_texture
	new_drag_item.mouse_filter = Control.MOUSE_FILTER_IGNORE
	new_drag_item.name = "ItemDrag"
	add_child(new_drag_item)
