extends Area2D

@export var slow_multiplier: float = 20.0

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.speed_multiplier = slow_multiplier

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.speed_multiplier = 30.0 
