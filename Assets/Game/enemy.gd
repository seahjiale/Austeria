extends RigidBody2D

@export var xp_reward: int = 10
@export var sprite: AnimatedSprite2D
@export var health: int = 3
@export var default_animation := "idle"

func on_hit():
	pass

func take_damage(amount):
	health -= amount
	
	on_hit()
	
	if health <= 0:
		ExpManager.gain_xp(xp_reward)
		call_deferred("queue_free")
		return
		
	sprite.play("take_damage")
	await sprite.animation_finished
	sprite.play(default_animation)
	
