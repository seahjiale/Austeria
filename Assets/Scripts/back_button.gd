extends TextureButton

@onready var icon = $BackButtonRect

func _on_mouse_entered():
	icon.position.y += 5

func _on_mouse_exited():
	icon.position.y -= 5

func _pressed():
	SceneTransition.transition_to("res://Assets/Scenes/Menus/main_menu.tscn")
