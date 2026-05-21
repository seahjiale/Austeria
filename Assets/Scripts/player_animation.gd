extends Node2D

@export var player_movement : PlayerMovement
@export var sprite : AnimatedSprite2D

var is_hurt = false

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
	
	# running animation
	if abs(player_movement.velocity.x) > 0:
		sprite.play("move")
	else:
		sprite.play("idle")
		
	# jump animation
	if player_movement.velocity.y < 0:
		sprite.play("jump")
	elif player_movement.velocity.y > 0:
		sprite.play("fall")
		
func _on_animated_sprite_2d_animation_finished() -> void:
	if sprite.animation == "hit":
		is_hurt = false
