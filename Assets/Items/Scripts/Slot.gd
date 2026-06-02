extends TextureRect
class_name Slot

@export var current_item : ItemData

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_item_slot()

func set_item_slot() -> void:
	if current_item == null:
		%ItemTexture.texture = null
		%ItemAmount.text = ""
		return
	%ItemTexture.texture = current_item.item_texture
	%ItemAmount.text = str(current_item.item_amount)
