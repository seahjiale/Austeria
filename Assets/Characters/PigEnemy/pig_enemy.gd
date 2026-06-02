extends "res://Assets/Game/enemy.gd"
@onready var game_manager = %GameManager
var direction = -1.0
var player: CharacterBody2D = null
var chasing = false
@export var chase_speed = 50.0
@export var drop_aggro_distance = 200.0

func _ready():
	player = get_tree().get_first_node_in_group("player")
	sprite.play("idle")

func on_hit():
	if chasing:
		return
	chasing = true
	default_animation = "run_aggro"

func _process(_delta):
	if chasing and is_instance_valid(player):
		var dir = sign(player.global_position.x - global_position.x)
		linear_velocity.x = dir * chase_speed
		sprite.flip_h = dir > 0
		if sprite.animation != "take_damage":
			sprite.play("run_aggro")
		if global_position.distance_to(player.global_position) > drop_aggro_distance:
			chasing = false
			linear_velocity.x = 0
			default_animation = "idle"
			sprite.play("idle")
	else:
		linear_velocity.x = 0

func _on_area_2d_body_entered(body) -> void:
	if body is CharacterBody2D:
		var x_delta = body.position.x - position.x
		body.get_node("PlayerAnimation").take_damage()
		game_manager.decrease_health()
		if (x_delta > 0):
			body.jump_side(100)
		else:
			body.jump_side(-100)
