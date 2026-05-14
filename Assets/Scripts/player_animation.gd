extends Node2D

@export var player_movement : PlayerMovement
@export var animation_player : AnimationPlayer
@export var sprite : Sprite2D

func _process(_delta):
	# direction of player
	if player_movement.direction == 1:
		sprite.flip_h = false
	elif player_movement.direction == -1:
		sprite.flip_h = true
	
	# running animation
	if abs(player_movement.velocity.x) > 0:
		animation_player.play("move")
	else:
		animation_player.play("idle")
		
	# jump animation
	if player_movement.velocity.y < 0:
		animation_player.play("jump")
	elif player_movement.velocity.y > 0:
		animation_player.play("fall")
