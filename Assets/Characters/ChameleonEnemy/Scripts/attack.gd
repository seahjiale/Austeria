extends State
@onready var tongue_hitbox = $"../../TongueHitBox"
@onready var game_manager = get_tree().get_first_node_in_group("GameManager")

func enter():
	super.enter()
	owner.can_move = false
	animation_player.play("Attack")
	await animation_player.animation_finished
	owner.start_attack_cooldown()
	get_parent().change_state("Idle")

func deal_damage():
	tongue_hitbox.monitoring = true
	await get_tree().create_timer(0.1).timeout
	tongue_hitbox.monitoring = false

func _on_tongue_hit_box_body_entered(body: Node2D) -> void:
	if body == owner:
		return
	if body is CharacterBody2D and body.is_in_group("player"):
		body.get_node("PlayerAnimation").take_damage()
		game_manager.decrease_health()

func transition():
	pass
