extends Node

@onready var music = $AudioStreamPlayer2D

func play_music(track: AudioStream):
	if music.stream == track and music.playing:
		return

	music.stream = track
	music.play()

func stop_music():
	music.stop()
