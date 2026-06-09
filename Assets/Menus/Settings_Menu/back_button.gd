extends TextureButton

@onready var icon = $BackButtonRect
@onready var button_sfx = $AudioStreamPlayer2D

func _on_mouse_entered():
	icon.position.y += 5

func _on_mouse_exited():
	icon.position.y -= 5

func _pressed():
	SceneTransition.transition_to("res://Assets/Menus/Main_Menu/main_menu.tscn")
	button_sfx.play()
