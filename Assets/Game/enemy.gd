extends RigidBody2D

@export var xp_reward: int = 10
@export var sprite: AnimatedSprite2D
@export var health: int = 3
@export var default_animation := "idle"
var is_dead = false

func on_hit():
	pass

var is_taking_damage: bool = false

func take_damage(amount):
	if is_dead:
		return
	if is_taking_damage:
		health -= amount
		if health <= 0:
			ExpManager.gain_xp(xp_reward)
			die()
		return
	health -= amount
	on_hit()
	
	if health <= 0:
		ExpManager.gain_xp(xp_reward)
		die()
		return
	
	is_taking_damage = true
	sprite.play("take_damage")
	await sprite.animation_finished
	is_taking_damage = false
	if health > 0:
		sprite.play(default_animation)

func die():
	is_dead = true
	set_physics_process(false)
	set_process(false)
	set_deferred("freeze", true)
	set_deferred("collision_layer", 0)
	set_deferred("collision_mask", 1)
	$Area2D/DamageDetection.set_deferred("disabled", true)
	sprite.stop()
	sprite.play("Death")
	await sprite.animation_finished
	queue_free()
