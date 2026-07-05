extends CharacterBody2D
 
@onready var player = get_tree().get_first_node_in_group("player")
@onready var game_manager = get_tree().get_first_node_in_group("GameManager")
@onready var animation_player = $AnimationPlayer
@onready var sprite = $FlyingDemonSprite
var player_detected: bool = false
var direction : Vector2
var can_move: bool = false
var is_dead: bool = false
const SPEED = 40.0

var health = 15:
	set(value):
		health = value
		if value <= 0:
			_die()

func _ready() -> void:
	pass

func _physics_process(_delta):
	if not can_move:
		return
	direction = (player.global_position - global_position).normalized()
	velocity.x = direction.normalized().x * SPEED
	velocity.y = direction.normalized().y * SPEED
	move_and_slide()

func _process(_delta):
	if player == null:
		player = get_tree().get_first_node_in_group("player")
		return
	direction = player.global_position - global_position
	if direction.x < 0:
		sprite.flip_h = false
	else:
		sprite.flip_h = true

func take_damage(amount: int):
	if is_dead:
		return
	health -= amount
	if health > 0:
		animation_player.play("Hurt")
		await animation_player.animation_finished
		if not is_dead:
			find_child("FiniteStateMachine").change_state("Flying")
	else:
		_die()

func _die() -> void:
	if is_dead:
		return
	is_dead = true
	ExpManager.gain_xp(40)
	velocity = Vector2.ZERO
	set_physics_process(false)
	$Hitbox.get_parent().collision_mask = 0
	$Hitbox.get_parent().collision_layer = 0
	find_child("FiniteStateMachine").change_state("Death")
