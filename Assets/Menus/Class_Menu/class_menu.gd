extends Control

@export var player_class_data: PlayerClassData
@export var warrior_class: CharacterClassData
@export var archer_class: CharacterClassData
@export var next_area_path: String = "res://Assets/Levels/Area1/area_1.tscn"

@onready var warrior_class_img = $Class_Panel/WarriorButton/WarriorClass
@onready var warrior_class_sword_img = $Class_Panel/WarriorButton/Sword
@onready var archer_class_img = $Class_Panel/ArcherButton/ArcherClass
@onready var archer_class_bow_img = $Class_Panel/ArcherButton/Bow
func _ready() -> void:
	GameState.selected_class = null

func _on_warrior_button_pressed() -> void:
	GameState.selected_class = warrior_class
	SceneTransition.transition_to(next_area_path)

func _on_archer_button_pressed() -> void:
	GameState.selected_class = archer_class
	SceneTransition.transition_to(next_area_path)

func _on_warrior_button_mouse_entered() -> void:
	warrior_class_img.position.y += 10
	warrior_class_sword_img.position.y += 10

func _on_warrior_button_mouse_exited() -> void:
	warrior_class_img.position.y -= 10
	warrior_class_sword_img.position.y -= 10

func _on_archer_button_mouse_entered() -> void:
	archer_class_img.position.y += 10
	archer_class_bow_img.position.y += 10

func _on_archer_button_mouse_exited() -> void:
	archer_class_img.position.y -= 10
	archer_class_bow_img.position.y -= 10
