extends State
var attack_cooldown: float = 0.0

func enter():
	super.enter()
	owner.can_move = true
	animation_player.play("Flying")
	attack_cooldown = 2.0

func exit():
	super.exit()

func transition():
	if attack_cooldown > 0:
		attack_cooldown -= get_physics_process_delta_time()
		return
	var distance = owner.direction.length()
	var horizontal_distance = abs(owner.direction.x)
	var vertical_distance = abs(owner.direction.y)
	if distance > 0 and horizontal_distance < 30 and vertical_distance < 30:
		get_parent().change_state("Attack")
