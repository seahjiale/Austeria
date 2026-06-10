extends Area2D

@onready var player: Node2D = get_tree().get_first_node_in_group("player")
@onready var animated_sprite = $AnimatedSprite2D
@onready var game_manager = get_tree().get_first_node_in_group("GameManager")

var acceleration: Vector2 = Vector2.ZERO 
var velocity: Vector2 = Vector2.ZERO

func _ready():
	get_tree().create_timer(2.0).timeout.connect(queue_free)
 
func _physics_process(delta):
	acceleration = (player.position - position).normalized() * 700 
	velocity += acceleration * delta
	rotation = velocity.angle() 
	velocity = velocity.limit_length(150) 
	position += velocity * delta
 
func _on_body_entered(body):
	if body is CharacterBody2D:
		body.get_node("PlayerAnimation").take_damage()
		game_manager.decrease_health()
	queue_free()
