extends RigidBody2D

@onready var game_manager = %GameManager

var health = 3

func take_damage(amount):
	health -= amount
	if health <= 0:
		call_deferred("queue_free")



func _on_area_2d_body_entered(body) -> void:
	if body is CharacterBody2D:
		var y_delta = position.y - body.position.y
		var x_delta = body.position.x - position.x
		if false == true: 
			take_damage(1)
			body.jump()
		else:
			body.get_node("PlayerAnimation").take_damage()
			game_manager.decrease_health()
			if (x_delta > 0):
				body.jump_side(100)
			else:
				body.jump_side(-100)
