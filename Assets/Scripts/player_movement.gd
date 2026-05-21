extends CharacterBody2D
class_name PlayerMovement

@export var speed = 10.0
@export var jump_power = 10.0

var speed_multiplier = 30.0
var jump_multiplier = -30.0
var direction = 0
var knockback = false
var knockback_timer = 0.0
var is_hurt = false

func _ready():
	# checking if it has passed any checkpoints, if yes reset position
	if GameState.respawn_position != Vector2.ZERO:
		global_position = GameState.respawn_position
	else:
		GameState.respawn_position = global_position
	
func _physics_process(delta: float) -> void:
	# gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# knockback track
	if knockback_timer > 0:
		knockback_timer -= delta
	else:
		knockback = false

	# jump action
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_power * jump_multiplier
	
	if not knockback:
		direction = Input.get_axis("move_left", "move_right")
		if direction:
			velocity.x = direction * speed * speed_multiplier
		else:
			velocity.x = move_toward(velocity.x, 0, speed_multiplier)
	move_and_slide()

func jump():
	velocity.y = jump_power * jump_multiplier

func jump_side(x):
	velocity.y = jump_power * jump_multiplier
	velocity.x = x
	knockback = true
	knockback_timer = 0.3
