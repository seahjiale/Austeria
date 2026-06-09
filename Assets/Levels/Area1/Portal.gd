extends Area2D

@export var class_menu_scene: String = "res://Assets/Menus/Class_Menu/class_menu.tscn"
@onready var press_f_label: Label = $PressFLabel

var player_nearby: bool = false

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_nearby = true
		press_f_label.visible = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_nearby = false
		press_f_label.visible = false

func _ready() -> void:
	press_f_label.visible = false
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _input(event: InputEvent) -> void:
	if player_nearby and event.is_action_pressed("interact"):
		get_tree().change_scene_to_file(class_menu_scene)
