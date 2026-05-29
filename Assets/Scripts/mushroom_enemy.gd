extends RigidBody2D

@onready var game_manager = %GameManager
@export var sprite : AnimatedSprite2D

# mushroom health
var health = 3

# takes damage, if health hits <= 0, disappear
func take_damage(amount):
	health -= amount
	if health <= 0:
		call_deferred("queue_free")
	sprite.play("take_damage")
	await sprite.animation_finished
	sprite.play("idle")

# checks if player gets hit or mushroom gets hit
func _on_area_2d_body_entered(body) -> void:
	if body is CharacterBody2D:
		var y_delta = position.y - body.position.y
		var x_delta = body.position.x - position.x
		if y_delta > 20: 
			body.jump()
			take_damage(1)
		else:
			body.get_node("PlayerAnimation").take_damage()
			game_manager.decrease_health()
			if (x_delta > 0):
				body.jump_side(100)
			else:
				body.jump_side(-100)
