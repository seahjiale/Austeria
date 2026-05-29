extends TextureButton

@onready var label = $RestartLabel

func _on_mouse_entered() -> void:
	label.position.y += 5


func _on_mouse_exited() -> void:
	label.position.y -= 5
