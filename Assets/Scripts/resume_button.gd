extends TextureButton

@onready var label = $ResumeLabel

func _on_mouse_entered():
	label.position.y += 5

func _on_mouse_exited():
	label.position.y -= 5
