extends TextureButton

@onready var icon = $Label
@onready var button_sfx = $AudioStreamPlayer2D

func _on_mouse_entered():
	icon.position.y += 5

func _on_mouse_exited():
	icon.position.y -= 5
