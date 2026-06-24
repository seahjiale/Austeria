extends Area2D

@export var speed: float = 200.0
@export var damage: int = 1
@export var lifetime: float = 1.0

var direction: Vector2 = Vector2.RIGHT

func _ready() -> void:
	add_to_group("player_attack")
	await get_tree().create_timer(lifetime).timeout
	queue_free()

func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta

func setup(new_direction: Vector2, new_damage: int) -> void:
	direction = new_direction.normalized()
	damage = new_damage
	rotation = direction.angle()

func get_attack_damage() -> int:
	return damage

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)
	queue_free()
