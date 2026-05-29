extends CharacterBody2D
class_name PlayerMovement

signal double_jumped

@onready var player_animation = $PlayerAnimation
@onready var attack_hitbox = $"Attack/AttackHitBox"
@export var speed = 10.0
@export var jump_power = 10.0

var speed_multiplier = 30.0
var jump_multiplier = -30.0
var direction = 0
# knockback check to finish animation
var knockback = false
var knockback_timer = 0.0
# check if hurt
var is_hurt = false
# double jump count
var jumps_remaining = 2

func _ready():
	# checking if it has passed any checkpoints, if yes reset position
	if GameState.respawn_position != Vector2.ZERO:
		global_position = GameState.respawn_position
	else:
		GameState.respawn_position = global_position
	
func _physics_process(delta: float) -> void:
	# resets double jump
	if is_on_floor():
		jumps_remaining = 2
	
	# gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# knockback track
	if knockback_timer > 0:
		knockback_timer -= delta
	else:
		knockback = false

	# double-jump logic and animation
	if Input.is_action_just_pressed("jump") and jumps_remaining > 0:
		velocity.y = jump_power * jump_multiplier
		jumps_remaining -= 1
		if jumps_remaining == 0:
			double_jumped.emit()
	
	# knockback logic and animation
	if not knockback:
		direction = Input.get_axis("move_left", "move_right")
		if direction:
			velocity.x = direction * speed * speed_multiplier
		else:
			velocity.x = move_toward(velocity.x, 0, speed_multiplier)
	move_and_slide()

func _input(event):
	if event.is_action_pressed("attack"):
		attack()

func jump():
	velocity.y = jump_power * jump_multiplier

# when player takes damage, bounces backwards of opposite direction
func jump_side(x):
	velocity.y = jump_power * jump_multiplier
	velocity.x = x
	knockback = true
	knockback_timer = 0.3

func attack():
	attack_hitbox.position.x = abs(attack_hitbox.position.x) * (-1 if player_animation.sprite.flip_h else 1)
	attack_hitbox.monitoring = true
	await player_animation.play_attack()
	attack_hitbox.monitoring = false

func _on_attack_hit_box_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(1)
