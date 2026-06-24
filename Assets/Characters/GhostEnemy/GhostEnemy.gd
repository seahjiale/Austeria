extends CharacterBody2D
 
@onready var player = get_tree().get_first_node_in_group("player")
@onready var game_manager = get_tree().get_first_node_in_group("GameManager")
@onready var animation_player = $AnimationPlayer
@onready var sprite = $GhostSprite
var player_detected: bool = false
var direction : Vector2
var is_hurt: bool = false
const SPEED = 40.0

var health = 5:
	set(value):
		health = value
		if value <= 0:
			_die()
 
func _ready():
	player = get_tree().get_first_node_in_group("player")
	animation_player.play("Idle")
	set_physics_process(true)

func _physics_process(_delta):
	if is_hurt:
		move_and_slide()
		return
	if player_detected:
		animation_player.play("Walk")
		var target_offset = Vector2(0, -10)  # 50 pixels above the player
		var target_position = player.global_position + target_offset
		direction = (target_position - global_position).normalized()
		velocity = direction.normalized() * SPEED
		if direction.x < 0:
			sprite.flip_h = true
		else:
			sprite.flip_h = false
		move_and_slide()

 
func take_damage(amount: int):
	health -= amount
	if health > 0:
		is_hurt = true
		animation_player.play("Hurt")
		if player:
			var knock_dir = (global_position - player.global_position).normalized()
			velocity = knock_dir * 80
		await animation_player.animation_finished
		is_hurt = false
	else:
		_die()

func _on_damage_area_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body.is_in_group("player"):
		body.get_node("PlayerAnimation").take_damage()
		game_manager.decrease_health()


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_hitbox") or area.is_in_group("player_attack"):
		var damage = player.get_attack_damage() if player.has_method("get_attack_damage") else 1
		take_damage(damage) # Replace with function body.

func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_detected = true # Replace with function body.

func _die() -> void:
	velocity = Vector2.ZERO
	set_physics_process(false)
	$Hitbox.monitoring = false
	$Hitbox.monitorable = false
	$DamageArea.monitoring = false
	$DamageArea.monitorable = false
	animation_player.play("Death")
	await animation_player.animation_finished
	queue_free()
	
