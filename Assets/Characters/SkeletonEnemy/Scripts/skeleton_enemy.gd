extends CharacterBody2D

@onready var sprite = $SkeletonSprite
@onready var player = get_tree().get_first_node_in_group("player")
@onready var animation_player = $AnimationPlayer
var direction : Vector2
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var is_dead: bool = false
var can_move: bool = false:
	set(value):
		can_move = value

var health = 6:
	set(value):
		health = value
		if value <= 0:
			_die()

func _ready() -> void:
	pass

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
	$RayCast2D.position.x = abs($RayCast2D.position.x) * (-1 if sprite.flip_h else 1)
	var edge_ahead = $RayCast2D.is_colliding()
	if edge_ahead:
		velocity.x = direction.normalized().x * 40
	else:
		velocity.x = 0
	move_and_slide()

func take_damage(amount: int):
	if is_dead:
		return
	health -= amount
	if health > 0:
		animation_player.play("Hurt")
		await animation_player.animation_finished
		if not is_dead:
			find_child("FiniteStateMachine").change_state("Walk")
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
