extends Node

@onready var music = $AudioStreamPlayer2D

func play_menu_music():
	if not music.playing:
		music.play()

func stop_music():
	music.stop()
