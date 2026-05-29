extends Control
	
# settings menu
func _on_settings_button_pressed() -> void:
	SceneTransition.transition_to("res://Assets/Menus/Settings_Menu/settings_menu.tscn")
	
# start the game
func _on_play_button_pressed() -> void:
	SceneTransition.transition_to("res://Assets/Levels/Area1/area_1.tscn")
