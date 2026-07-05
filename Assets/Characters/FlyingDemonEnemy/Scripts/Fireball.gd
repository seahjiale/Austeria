extends Area2D

@onready var game_manager = get_tree().get_first_node_in_group("GameManager")
@export var speed: float = 200.0
@export var damage: int = 1
@export var lifetime: float = 1.0
var direction: Vector2 = Vector2.RIGHT

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_manager = get_tree().current_scene.get_node("%GameManager")
	await get_tree().create_timer(lifetime).timeout
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta

func setup(new_direction: Vector2) -> void:
	direction = new_direction.normalized()
	rotation = direction.angle()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group('enemy'):
		return
	if body is CharacterBody2D and body.is_in_group("player"):
		body.get_node("PlayerAnimation").take_damage()
		game_manager.decrease_health()
	queue_free()
