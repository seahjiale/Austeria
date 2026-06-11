extends State
 
@onready var pivot = $"../../LaserPivot"
var can_transition: bool = false
@onready var game_manager = get_tree().get_first_node_in_group("GameManager")
@onready var laser_hitbox = $"../../LaserPivot/LaserHitbox"

var laser_active: bool = false
 
func enter():
	super.enter()
	laser_hitbox.monitoring = false
	set_target()
	await play_animation("laser_cast")
	await play_animation("laser")
	can_transition = true

func exit():
	super.exit()
	laser_hitbox.monitoring = false
 
func deal_damage():
	laser_hitbox.monitoring = true
	# Disable after a short window so it only hits mid-animation
	await get_tree().create_timer(0.1).timeout
	laser_hitbox.monitoring = false

func play_animation(anim_name):
	animation_player.play(anim_name)
	await animation_player.animation_finished
 
func set_target():
	pivot.rotation = (owner.player.position - pivot.global_position).angle()
 
func transition():
	if can_transition:
		can_transition = false
		get_parent().change_state("Dash")

func _on_laser_hitbox_body_entered(body: Node2D) -> void:
	if body == owner:
		return
	if body is CharacterBody2D and body.is_in_group("player"):
		body.get_node("PlayerAnimation").take_damage()
		game_manager.decrease_health()
