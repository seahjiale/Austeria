extends CharacterBody2D
class_name PlayerMovement

signal double_jumped

@export var arrow_scene: PackedScene
@onready var arrow_spawn_point: Marker2D = $ArrowSpawnPoint
@export var player_class_data: PlayerClassData
var current_class: CharacterClassData = null
var equipped_weapon: WeaponData = null
var base_damage: int = 1
var attack_type: String = "melee"

@onready var player_animation = $PlayerAnimation
@onready var attack_hitbox = $"Attack/AttackHitBox"
@export var health = 3.0
@export var speed = 10.0
@export var jump_power = 10.0
@export var attack_cooldown: float = 0.5

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
var can_attack: bool = true

@onready var level_up_label = $LevelUpEffect/LevelUpLabel
var level_up_label_start_pos: Vector2

# Basic attack sound effect
@onready var attack_sound = $AttackSound
@onready var jump_sound = $JumpSound

func get_current_class() -> CharacterClassData:
	return current_class

func _ready():
	level_up_label_start_pos = level_up_label.position
	apply_selected_class()
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
		jump_sound.play()
		velocity.y = jump_power * jump_multiplier
		jumps_remaining -= 1
		if jumps_remaining == 0:
			jump_sound.play()
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
		
	if event.is_action_pressed("skill_1"):
		use_skill(0)
	if event.is_action_pressed("skill_2"):
		use_skill(1)
	if event.is_action_pressed("skill_3"):
		use_skill(2)
	if event.is_action_pressed("skill_4"):
		use_skill(3)
	
	#delete after finish debugging
	if event.is_action_pressed("debug_skill_point"):
		SkillManager.add_skill_point(1)
		print("Skill points: ", SkillManager.skill_points)
		
var level_up_tween: Tween

func play_level_up_effect():
	var beam = $LevelUpEffect/Beam
	var ring = $LevelUpEffect/Ring
	var sparkles = $LevelUpEffect/Sparkles
	var label = $LevelUpEffect/LevelUpLabel

	var ring_base_scale = Vector2(0.02, 0.02)

	# Start sparkles
	sparkles.restart()
	sparkles.emitting = true

	# Reset beam
	beam.visible = true
	beam.modulate.a = 0.0

	# Reset ring
	ring.visible = true
	ring.modulate.a = 1.0
	ring.scale = ring_base_scale * 0.7

	# Reset label
	label.visible = true
	label.modulate.a = 1.0
	label.scale = Vector2(0.5, 0.5)

	label.position = level_up_label_start_pos

	if level_up_tween:
		level_up_tween.kill()

	level_up_tween = create_tween()
	var tween = level_up_tween

	# Beam fade in
	tween.parallel().tween_property(
		beam,
		"modulate:a",
		1.0,
		0.1)

	# Beam fade out
	tween.parallel().tween_property(
		beam,
		"modulate:a",
		0.0,
		0.4).set_delay(0.2)

	# Ring expand
	tween.parallel().tween_property(
		ring,
		"scale",
		ring_base_scale * 1.3,
		0.5)

	# Ring fade
	tween.parallel().tween_property(
		ring,
		"modulate:a",
		0.0,
		0.5)

	# LEVEL UP text pop
	tween.parallel().tween_property(
		label,
		"scale",
		Vector2(1.0, 1.0),
		0.2)

	# Float upward
	tween.parallel().tween_property(
		label,
		"position",
		level_up_label_start_pos + Vector2(0, -25),
		0.8)

	# Fade text
	tween.parallel().tween_property(
		label,
		"modulate:a",
		0.0,
		0.8)

	await tween.finished

	beam.visible = false
	ring.visible = false
	label.visible = false
  
func jump():
	velocity.y = jump_power * jump_multiplier

# when player takes damage, bounces backwards of opposite direction
func jump_side(x):
	velocity.y = jump_power * jump_multiplier
	velocity.x = x
	knockback = true
	knockback_timer = 0.3

func attack():
	if attack_type == "ranged":
		await ranged_attack()
	else:
		await melee_attack()

func ranged_attack():
	if not can_attack:
		return
	can_attack = false
	if arrow_scene == null:
		can_attack = true
		return
	var arrow = arrow_scene.instantiate()
	var mouse_pos = get_global_mouse_position()
	var spawn_offset_x = abs(arrow_spawn_point.position.x) if mouse_pos.x >= global_position.x else -abs(arrow_spawn_point.position.x)
	var spawn_pos = global_position + Vector2(spawn_offset_x, arrow_spawn_point.position.y)
	var direction = (mouse_pos - spawn_pos).normalized()
	get_parent().add_child(arrow)
	arrow.global_position = spawn_pos
	arrow.setup(direction, get_attack_damage())
	arrow.rotation = direction.angle()
	await get_tree().create_timer(attack_cooldown).timeout
	can_attack = true

func melee_attack():
	if not can_attack:
		return
	can_attack = false
	attack_hitbox.position.x = abs(attack_hitbox.position.x) * (-1 if player_animation.sprite.flip_h else 1)
	attack_hitbox.monitoring = true
	attack_hitbox.monitorable = true
	attack_sound.play()
	await player_animation.play_attack()
	attack_hitbox.monitoring = false
	attack_hitbox.monitorable = false
	hit_bodies.clear()
	
	await get_tree().create_timer(attack_cooldown).timeout
	can_attack = true

func equip_weapon(weapon: WeaponData) -> void:
	equipped_weapon = weapon
	player_animation.equip_weapon(weapon)
	if weapon == null:
		print("Weapon unequipped")
	else:
		print("Equipped weapon: ", weapon.item_name)

func get_attack_damage() -> int:
	if equipped_weapon != null:
		return equipped_weapon.damage
	return base_damage

var hit_bodies: Array = []

func _on_attack_hit_box_body_entered(body: Node2D) -> void:
	if body in hit_bodies:
		return
	if body.has_method("take_damage"):
		hit_bodies.append(body)
		body.take_damage(get_attack_damage())

func apply_selected_class() -> void:
	if player_class_data == null:
		return
		
	if GameState.selected_class == null:
		return
	
	current_class = GameState.selected_class
	health = current_class.max_health
	speed = current_class.speed
	jump_power = current_class.jump_power
	base_damage = current_class.base_damage
	attack_type = current_class.attack_type
	player_animation.base_attack_animation = current_class.base_attack_animation


# SKILLS CODE
func use_skill(slot_index: int) -> void:
	var skill = SkillManager.get_skill(slot_index)
	if skill == null:
		return
	if SkillManager._cooldowns[slot_index] > 0.0:
		return
	SkillManager.use_skill(slot_index)
	match skill.id:
		"rock_spike":
			use_rock_spike()
		"laser_beam":
			use_laser_beam()
		"shadow_walker":
			use_shadow_walker()

@export var rock_spike_scene: PackedScene
@export var rock_spike_distance: float = 80.0
var can_use_rock_spike: bool = true
const ROCK_SPIKE_COOLDOWN: float = 2.0

func use_rock_spike() -> void:
	var facing := -1 if player_animation.sprite.flip_h else 1
	var spawn_pos := global_position + Vector2(rock_spike_distance * facing, 0)
	var spike = rock_spike_scene.instantiate()
	spike.setup(facing)
	spike.global_position = spawn_pos
	get_parent().add_child(spike)

@export var laser_beam_scene: PackedScene
var LASER_DIAGONAL := Vector2(1, 1).normalized()
var can_use_laser_beam: bool = true
const LASER_COOLDOWN: float = 2.5

func use_laser_beam() -> void:
	var facing := -1 if player_animation.sprite.flip_h else 1
	var dir := Vector2(facing, 0)
	var laser = laser_beam_scene.instantiate()
	laser.setup(dir, get_attack_damage())
	laser.global_position = global_position + Vector2(facing + 55, -10)
	get_parent().add_child(laser)
	
@export var shadow_walker_scene: PackedScene
@export var shadow_walker_distance: float = 80.0
var can_use_shadow_walker: bool = true
const SHADOW_WALKER_COOLDOWN: float = 1.0
func use_shadow_walker() -> void:
	var facing := -1 if player_animation.sprite.flip_h else 1
	var spawn_pos := global_position + Vector2(shadow_walker_distance * facing, -30)
	var spike = shadow_walker_scene.instantiate()
	spike.setup(facing)
	spike.global_position = spawn_pos
	get_parent().add_child(spike)
