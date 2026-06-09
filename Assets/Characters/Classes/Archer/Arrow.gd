extends Area2D

@export var speed: float = 200.0
@export var damage: int = 1
@export var lifetime: float = 1.0

var direction: int = 1

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	await get_tree().create_timer(lifetime).timeout
	queue_free()

func _physics_process(delta: float) -> void:
	global_position.x += direction * speed * delta

func setup(new_direction: int, new_damage: int) -> void:
	direction = new_direction
	damage = new_damage

	if direction == -1:
		scale.x = -abs(scale.x)
	else:
		scale.x = abs(scale.x)

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)
	queue_free()
