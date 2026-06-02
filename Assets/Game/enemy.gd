extends RigidBody2D

@export var xp_reward: int = 10
@export var sprite: AnimatedSprite2D
var health: int = 3

func take_damage(amount):
	health -= amount
	if health <= 0:
		ExpManager.gain_xp(xp_reward)
		call_deferred("queue_free")
		return
	sprite.play("take_damage")
	await sprite.animation_finished
	sprite.play("idle")
