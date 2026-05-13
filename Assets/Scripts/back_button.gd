extends TextureButton

@onready var icon = $BackButtonRect

func _on_mouse_entered():
	icon.position.y += 5

func _on_mouse_exited():
	icon.position.y -= 5

func _pressed():
	get_tree().change_scene_to_file("res://Assets/Scenes/MainMenu/main_menu.tscn")
