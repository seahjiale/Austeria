extends Control
	
	

# settings menu
func _on_settings_button_pressed() -> void:
	SceneTransition.transition_to("res://Assets/Scenes/MainMenu/settings_menu.tscn")
	
# start the game
func _on_play_button_pressed() -> void:
	SceneTransition.transition_to("res://Assets/Scenes/Areas/area_1.tscn")
