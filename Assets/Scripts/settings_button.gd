extends TextureButton

@onready var label = $SettingsLabel

func _on_mouse_entered():
	label.position.y += 2

func _on_mouse_exited():
	label.position.y -= 2


func _on_quit_button_mouse_entered() -> void:
	pass # Replace with function body.
