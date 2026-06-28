extends "res://Assets/Game/enemy.gd"

@onready var game_manager = %GameManager
@onready var timer: Timer = $Timer

var speed = 30.0
var direction = -1.0
var paused = false
var state = "run"
	
func _ready():
	default_animation = "run"
	sprite.play("run")
	timer.start()
	
func _process(delta: float) -> void:
	if !paused:
		position.x += direction * speed * delta

func _on_area_2d_body_entered(body) -> void:
	if is_dead:
		return
	if body is CharacterBody2D:
		var x_delta = body.position.x - position.x
		body.get_node("PlayerAnimation").take_damage()
		game_manager.decrease_health()
		if (x_delta > 0):
			body.jump_side(100)
		else:
			body.jump_side(-100)


func _on_timer_timeout() -> void:
	if is_dead:
		return
	paused = true
	state = "idle"
	sprite.play("idle")
	
	await get_tree().create_timer(2.0).timeout
	if is_dead:
		return
	
	state = "run"
	direction *= -1
	sprite.flip_h = !sprite.flip_h
	paused = false
	sprite.play("run")
	timer.start()

func on_hit():
	default_animation = state
