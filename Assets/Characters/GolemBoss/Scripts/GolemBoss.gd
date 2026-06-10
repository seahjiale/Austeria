extends CharacterBody2D

@onready var sprite = $GolemSprite
@onready var progress_bar = $UI/ProgressBar
const SPEED = 300
var direction : Vector2
var DEF = 0
var player: Node2D
var can_move: bool = false:
	set(value):
		can_move = value
 
var health = 100:
	set(value):
		health = value
		progress_bar.value = value
		if value <= 0:
			progress_bar.visible = false
			find_child("FiniteStateMachine").change_state("Death")

func _ready():
	pass
 
func _process(_delta):
	if player == null:
		player = get_tree().get_first_node_in_group("player")
		return
	direction = player.global_position - global_position

	direction = player.position - position
	if direction.x < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
 
func _physics_process(delta):
	if not can_move:
		return
	velocity = direction.normalized() * 40
	move_and_collide(velocity * delta)
 
func take_damage(amount: int):
	health -= amount - DEF
