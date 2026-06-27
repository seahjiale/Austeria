extends Area2D

@export var damage: int = 2
var hit_bodies: Array = []
var facing: int = 1

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	monitoring = true
	monitorable = true
	body_entered.connect(_on_body_entered)
	if facing < 0:
		anim_sprite.flip_h = true
	anim_sprite.play("attack")
	await anim_sprite.animation_finished
	queue_free()

func setup(new_facing: int) -> void:
	facing = new_facing

func _on_body_entered(body: Node2D) -> void:
	if body in hit_bodies:
		return
	if body.has_method("take_damage"):
		hit_bodies.append(body)
		body.take_damage(damage)
