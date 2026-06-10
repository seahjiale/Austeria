extends Control

@export var player_class_data: PlayerClassData
@export var warrior_class: CharacterClassData
@export var archer_class: CharacterClassData
@export var next_area_path: String = "res://Assets/Levels/Area 2/Area 2.tscn"

func _ready() -> void:
	GameState.selected_class = null

func _on_warrior_button_pressed() -> void:
	GameState.selected_class = warrior_class
	SceneTransition.transition_to(next_area_path)

func _on_archer_button_pressed() -> void:
	GameState.selected_class = archer_class
	SceneTransition.transition_to(next_area_path)
