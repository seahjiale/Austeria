extends Control

@onready var button_sfx = $VBoxContainer/AudioStreamPlayer2D

func _ready():
	MusicManager.play_menu_music()

# settings menu
func _on_settings_button_pressed() -> void:
	button_sfx.play()
	SceneTransition.transition_to("res://Assets/Menus/Settings_Menu/settings_menu.tscn")
	
# start the game
func _on_play_button_pressed() -> void:
	button_sfx.play()
	SceneTransition.transition_to("res://Assets/Levels/Area1/area_1.tscn")
	MusicManager.stop_music()
