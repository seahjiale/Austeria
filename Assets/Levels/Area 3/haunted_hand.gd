extends Area2D

@onready var dust: AnimatedSprite2D = $Dust
@onready var hand: Sprite2D = $Hand
@onready var jump: Label = $Label
@export var slow_multiplier: float = 0.4
@export var escape_presses: int = 5  # number of space presses to escape
@export var cooldown_time: float = 2.0

var player_in_zone: bool = false
var hand_active: bool = false
var on_cooldown: bool = false
var press_count: int = 0
var trapped_player = null

func _ready():
	hand.visible = false
	dust.visible = true
	jump.visible = false
	dust.frame_changed.connect(_on_dust_frame_changed)

func _on_dust_frame_changed() -> void:
	if player_in_zone and not hand_active and not on_cooldown and dust.frame >= 3:
		hand_active = true
		hand.visible = true
		jump.visible = true
		press_count = 0
		if trapped_player:
			trapped_player.speed_multiplier = slow_multiplier
			trapped_player.is_trapped = true
			trapped_player.velocity.y = 0

func _input(event: InputEvent) -> void:
	if hand_active and event.is_action_pressed("jump"):
		press_count += 1
		if press_count >= escape_presses:
			_release_player()

func _release_player() -> void:
	hand_active = false
	hand.visible = false
	jump.visible = false
	press_count = 0
	if trapped_player:
		trapped_player.speed_multiplier = 30.0
		trapped_player.is_trapped = false
	on_cooldown = true
	await get_tree().create_timer(cooldown_time).timeout
	on_cooldown = false
	if player_in_zone:
		dust.frame = 0
		dust.play()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_zone = true
		trapped_player = body
		if not on_cooldown:
			dust.play()

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_zone = false
		trapped_player = null
		if not hand_active:
			hand.visible = false
			dust.stop()
			dust.frame = 0
