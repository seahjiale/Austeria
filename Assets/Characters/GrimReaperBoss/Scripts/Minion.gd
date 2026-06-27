extends CharacterBody2D
 
@onready var player = Node2D
@onready var game_manager = get_tree().get_first_node_in_group("GameManager")
@onready var animation = $MinionSprite
var direction : Vector2
const SPEED = 40.0

var health = 1:
	set(value):
		health = value
		if value <= 0:
			queue_free()
 
func _ready():
	player = get_tree().get_first_node_in_group("player")
	animation.play("Idle")
	set_physics_process(true)

func _physics_process(_delta):
	if not player:
		player = get_tree().get_first_node_in_group("player")
	direction = player.global_position - global_position
	velocity = direction.normalized() * SPEED
	move_and_slide()

 
func take_damage(amount: int):
	health -= amount

func _on_damage_area_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body.is_in_group("player"):
		body.get_node("PlayerAnimation").take_damage()
		game_manager.decrease_health()


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_hitbox") or area.is_in_group("player_attack"):
		take_damage(1) # Replace with function body.
