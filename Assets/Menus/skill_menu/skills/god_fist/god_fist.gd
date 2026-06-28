extends Area2D
@export var damage: int = 2
var facing: int = 1
@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	add_to_group("player_attack")
	monitoring = true
	monitorable = true
	if facing < 0:
		anim_sprite.flip_h = true
	await get_tree().create_timer(0.1).timeout  # small delay for area to detect overlaps
	await _do_punch("fist1")
	await _do_punch("fist2")
	await _do_punch("fist3")
	queue_free()


func setup(new_facing: int) -> void:
	facing = new_facing

func _do_punch(anim_name: String) -> void:
	var hit_bodies: Array = []
	for body in get_overlapping_bodies():
		if body in hit_bodies:
			continue
		if body.has_method("take_damage"):
			hit_bodies.append(body)
			body.take_damage(damage)
	anim_sprite.play(anim_name)
	await anim_sprite.animation_finished
	await get_tree().create_timer(0.1).timeout
