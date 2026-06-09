extends Control

@export var player_class_data: PlayerClassData
@export var warrior_class: CharacterClassData
@export var archer_class: CharacterClassData
@export var next_area_path: String = "res://Assets/Levels/Area 2/Area 2.tscn"

func _on_warrior_button_pressed() -> void:
	player_class_data.selected_class = warrior_class
	get_tree().change_scene_to_file(next_area_path)

func _on_archer_button_pressed() -> void:
	player_class_data.selected_class = archer_class
	get_tree().change_scene_to_file(next_area_path)
