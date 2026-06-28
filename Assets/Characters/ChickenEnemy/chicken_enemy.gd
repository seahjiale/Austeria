extends "res://Assets/Game/enemy.gd"

@onready var game_manager = %GameManager
@onready var timer: Timer = $Timer

var speed = 30.0
var direction = -1.0
var paused = false
	
func _ready():
	sprite.play("run")
	timer.start()
	
func _process(delta: float) -> void:
	if !paused:
		position.x += direction * speed * delta

func _on_area_2d_body_entered(body) -> void:
	if body is CharacterBody2D:
		var x_delta = body.position.x - position.x
		body.get_node("PlayerAnimation").take_damage()
		game_manager.decrease_health()
		if (x_delta > 0):
			body.jump_side(100)
		else:
			body.jump_side(-100)


func _on_timer_timeout() -> void:
	paused = true
	sprite.play("idle")
	
	await get_tree().create_timer(2.0).timeout
	print(health)
	
	if health <= 0:
		return
	
	direction *= -1
	sprite.flip_h = !sprite.flip_h
	paused = false
	sprite.play("run")
	timer.start()
