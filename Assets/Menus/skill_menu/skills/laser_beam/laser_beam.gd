extends Area2D

@export var damage: int = 1
var direction: Vector2 = Vector2.RIGHT
var hit_bodies: Array = []

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	monitoring = true
	monitorable = true
	
	body_entered.connect(_on_body_entered)
	if direction.x < 0:
		anim.flip_h = true
	anim.play("slash")
	_check_overlaps_immediately()
	await anim.animation_finished
	queue_free()

func setup(new_direction: Vector2, new_damage: int) -> void:
	direction = new_direction.normalized()
	damage = new_damage

func _check_overlaps_immediately() -> void:
	await get_tree().physics_frame
	for body in get_overlapping_bodies():
		_on_body_entered(body)

func _on_body_entered(body: Node2D) -> void:
	if body in hit_bodies:
		return
	if body.has_method("take_damage"):
		hit_bodies.append(body)
		body.take_damage(damage)
