extends Resource
class_name InventoryData

@export var item_data : Array[ItemData] = []

func add_item(item: ItemData) -> bool:
	for i in range(item_data.size()):
		if item_data[i] == null:
			item_data[i] = item
			return true

	item_data.append(item)
	return true

func remove_item(index: int) -> void:
	if index >= 0 and index < item_data.size():
		item_data[index] = null
