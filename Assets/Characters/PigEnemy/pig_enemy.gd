extends "res://Assets/Game/enemy.gd"

@onready var game_manager = %GameManager

var speed = 20.0
var direction = -1.0

var player: CharacterBody2D = null
var chasing = false

@export var patrol_speed = 20.0
@export var chase_speed = 50.0
@export var drop_aggro_distance = 300.0

func _ready():
	player = get_tree().get_first_node_in_group("player")
	
func on_hit():
	chasing = true

func _process(delta):
	if chasing and player:
		var dir = sign(player.global_position.x - global_position.x)
		position.x += dir * chase_speed * delta
		sprite.flip_h = dir < 0
		if global_position.distance_to(player.global_position) > drop_aggro_distance:
			chasing = false
	else:
		# Patrol behaviour here
		position.x += direction * patrol_speed * delta

func _on_area_2d_body_entered(body) -> void:
	if body is CharacterBody2D:
		var x_delta = body.position.x - position.x
		body.get_node("PlayerAnimation").take_damage()
		game_manager.decrease_health()
		if (x_delta > 0):
			body.jump_side(100)
		else:
			body.jump_side(-100)
