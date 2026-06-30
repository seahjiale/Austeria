extends Area2D

var player_nearby: bool = false
@onready var ui: CanvasLayer = $"../UI"

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_nearby = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_nearby = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _input(event: InputEvent) -> void:
	if player_nearby and event.is_action_pressed("interact"):
		ui.hide()
		$"../SkillUI".hide()
		GameState.respawn_position = Vector2.ZERO
		GameState.current_area = "res://Assets/Levels/Area 3/Area 3.tscn"
		SceneTransition.transition_to("res://Assets/Levels/Area 3/Area 3.tscn")
