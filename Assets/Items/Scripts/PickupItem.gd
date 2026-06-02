extends Area2D
class_name PickupItem

@export var item_data: ItemData
@export var inventory_data: InventoryData

@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)

	if item_data != null:
		sprite.texture = item_data.item_texture

func _on_body_entered(body: Node2D) -> void:
	if body.name != "Player":
		return

	if item_data == null:
		return

	if inventory_data == null:
		return
	
	inventory_data.add_item(item_data)
	GlobalSignals.update_inventory.emit()
	queue_free()
