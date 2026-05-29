extends RigidBody2D

@onready var game_manager = %GameManager
@export var sprite : AnimatedSprite2D

var health = 5

func take_damage(amount):
	health -= amount
	if health <= 0:
		call_deferred("queue_free")
	sprite.play("take_damage")
	await sprite.animation_finished
	sprite.play("idle")


func _on_area_2d_body_entered(body) -> void:
	if body is CharacterBody2D:
		var x_delta = body.position.x - position.x
		body.get_node("PlayerAnimation").take_damage()
		game_manager.decrease_health()
		if (x_delta > 0):
			body.jump_side(100)
		else:
			body.jump_side(-100)
