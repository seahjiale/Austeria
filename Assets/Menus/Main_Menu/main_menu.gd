extends Control

@onready var button_sfx = $VBoxContainer/AudioStreamPlayer2D

func _ready():
	MusicManager.play_music(load("res://Assets/Sound/Maplestory Theme Music - Intro.mp3"))

# settings menu
func _on_settings_button_pressed() -> void:
	button_sfx.play()
	SceneTransition.transition_to("res://Assets/Menus/Settings_Menu/settings_menu.tscn")
	
# start the game
func _on_play_button_pressed() -> void:
	GameState.reset()
	ExpManager.reset()
	SkillManager.reset()
	button_sfx.play()
	SceneTransition.transition_to("res://Assets/Levels/Area1/area_1.tscn")
	MusicManager.stop_music()
