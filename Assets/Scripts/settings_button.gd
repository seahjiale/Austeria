extends TextureButton

@onready var label = $SettingsLabel

func _on_mouse_entered():
	label.position.y += 5

func _on_mouse_exited():
	label.position.y -= 5

func _pressed():
	get_tree().change_scene_to_file("res://Assets/Scenes/MainMenu/settings_menu.tscn")
