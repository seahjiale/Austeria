extends State

@onready var pivot = $"../../MeleePivot"
@onready var game_manager = get_tree().get_first_node_in_group("GameManager")
@onready var melee_hitbox = $"../../MeleePivot/MeleeHitbox"
var can_transition: bool = false

func enter():
	super.enter()
	can_transition = false
	if owner.direction.x < 0:
		pivot.scale.x = -1
	else:
		pivot.scale.x = 1
	animation_player.play("Attack")
	await get_tree().create_timer(1).timeout
	can_transition = true

func deal_damage():
	melee_hitbox.monitoring = true
	await get_tree().create_timer(0.1).timeout
	melee_hitbox.monitoring = false

func transition():
	if can_transition:
		var horizontal_distance = abs(owner.direction.x)
		if horizontal_distance > 30:
			get_parent().change_state("Run")


func _on_melee_hitbox_body_entered(body: Node2D) -> void:
	if body == owner:
		return
	if body is CharacterBody2D and body.is_in_group("player"):
		body.get_node("PlayerAnimation").take_damage()
		game_manager.decrease_health()
