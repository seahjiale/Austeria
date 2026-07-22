extends TextureButton

@onready var icon = $Label
@onready var button_sfx = $AudioStreamPlayer2D
@onready var control_menu = $"../../ControlsMenu"

func _ready():
	control_menu.visible = false

func _on_mouse_entered():
	icon.position.y += 5

func _on_mouse_exited():
	icon.position.y -= 5

func _pressed():
	control_menu.visible = true
	button_sfx.play()
