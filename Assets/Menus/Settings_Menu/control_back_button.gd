extends TextureButton

@onready var icon = $BackButtonRect
@onready var button_sfx = $AudioStreamPlayer2D
@onready var control_menu = $"../../ControlsMenu"

func _on_mouse_entered():
	icon.position.y += 5

func _on_mouse_exited():
	icon.position.y -= 5

func _pressed():
	control_menu.visible = false
	button_sfx.play()
