extends CharacterBody2D
@onready var sprite = $ChameleonEnemySprite
@onready var player = get_tree().get_first_node_in_group("player")
@onready var tongue_hitbox = $TongueHitBox
@export var xp_reward: int = 80
@onready var game_manager = %GameManager

var can_attack := true
@export var attack_cooldown := 3.0

var direction : Vector2
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var can_move: bool = false:
	set(value):
		can_move = value

var health = 6:
	set(value):
		health = value
		if value <= 0:
			_die()

func _ready() -> void:
	tongue_hitbox.monitoring = false
	# Compensates for the body sitting right-of-center within each frame's
	# cell in the source spritesheets. Negative shifts the drawn texture left.
	# Tweak this value until the body looks centered.
	sprite.offset.x = -10

func _process(_delta):
	if player == null:
		player = get_tree().get_first_node_in_group("player")
		return
	direction = player.global_position - global_position

func _physics_process(delta):
	if not can_move:
		return
	if not is_on_floor():
		velocity.y += get_gravity().y * delta
	velocity.x = direction.normalized().x * 40
	move_and_slide()

func enable_tongue_hitbox() -> void:
	tongue_hitbox.monitoring = true

func disable_tongue_hitbox() -> void:
	tongue_hitbox.monitoring = false

func take_damage(amount: int):
	health -= amount
	if health > 0:
		sprite.play("Hurt")
		await sprite.animation_finished
		find_child("FiniteStateMachine").change_state("Idle")
	else:
		_die()
 
func _die() -> void:
	ExpManager.gain_xp(xp_reward)
	velocity = Vector2.ZERO
	set_physics_process(false)
	$HitBox.get_parent().collision_mask = 0
	$HitBox.get_parent().collision_layer = 0
	find_child("FiniteStateMachine").change_state("Death")

func start_attack_cooldown():
	can_attack = false
	await get_tree().create_timer(attack_cooldown).timeout
	can_attack = true



func _on_tongue_hit_box_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		var x_delta = body.position.x - position.x
		body.get_node("PlayerAnimation").take_damage()
		game_manager.decrease_health()
		if (x_delta > 0):
			body.jump_side(100)
		else:
			body.jump_side(-100)


func _on_collision_area_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return
	if body is CharacterBody2D:
		var x_delta = body.position.x - position.x
		body.get_node("PlayerAnimation").take_damage()
		game_manager.decrease_health()
		if (x_delta > 0):
			body.jump_side(100)
		else:
			body.jump_side(-100)
