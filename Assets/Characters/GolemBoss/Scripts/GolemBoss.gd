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
 
var health = 50:
	set(value):
		health = value
		progress_bar.value = value
		if value <= 0:
			progress_bar.visible = false
			find_child("FiniteStateMachine").change_state("Death")

func _ready():
	progress_bar.max_value = health
	progress_bar.value = health
 
func _process(_delta):
	if player == null:
		player = get_tree().get_first_node_in_group("player")
		return
	direction = player.global_position - global_position
	if direction.x < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
 
func _physics_process(delta):
	if not can_move:
		return
	if not is_on_floor():
		velocity.y += get_gravity().y * delta
	velocity.x = direction.normalized().x * 40
	move_and_slide()
 
func take_damage(amount: int):
	health -= amount - DEF
