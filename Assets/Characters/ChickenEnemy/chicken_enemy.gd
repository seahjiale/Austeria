extends "res://Assets/Game/enemy.gd"

@onready var game_manager = %GameManager
@onready var timer: Timer = $Timer
@onready var fsm = $FiniteStateMachine

var speed = 30.0
var direction = -1.0
var can_move := true

func _ready():
	default_animation = "Run"

func _process(delta: float) -> void:
	if can_move:
		position.x += direction * speed * delta

func _on_area_2d_body_entered(body) -> void:
	if is_dead:
		return
	if body is CharacterBody2D:
		var x_delta = body.position.x - position.x
		body.get_node("PlayerAnimation").take_damage()
		game_manager.decrease_health()
		if x_delta > 0:
			body.jump_side(100)
		else:
			body.jump_side(-100)

func _on_timer_timeout() -> void:
	if is_dead:
		return
	fsm.change_state("Idle")

func on_hit():
	default_animation = fsm.current_state.name
