extends Node2D

@export var player_movement : PlayerMovement
@export var sprite : AnimatedSprite2D
@onready var attack_sprite = $"../Attack/AttackSprite"

var is_hurt = false
var is_double_jumping = false

func _ready():
	player_movement.double_jumped.connect(_on_double_jump)

func _on_double_jump():
	if is_hurt:
		return
	is_double_jumping = true
	sprite.play("double_jump")

func take_damage():
	is_hurt = true
	sprite.play("hit")

func _process(_delta):
	if is_hurt:
		return
		
	# direction of player
	if player_movement.direction == 1:
		sprite.flip_h = false
	elif player_movement.direction == -1:
		sprite.flip_h = true
		
	if is_double_jumping:
		return
	
	if player_movement.velocity.y < 0:
		sprite.play("jump")
	elif player_movement.velocity.y > 0:
		sprite.play("fall")
	elif player_movement.is_on_floor():
		if abs(player_movement.velocity.x) > 0:
			sprite.play("move")
		else:
			sprite.play("idle")
		
func _on_animated_sprite_2d_animation_finished() -> void:
	if sprite.animation == "hit":
		is_hurt = false
	if sprite.animation == "double_jump":
		is_double_jumping = false


func play_attack():
	attack_sprite.flip_h = sprite.flip_h
	attack_sprite.position.x = abs(attack_sprite.position.x) * (-1 if sprite.flip_h else 1)
	attack_sprite.show()
	attack_sprite.play("attack")
	await attack_sprite.animation_finished
	attack_sprite.hide()
