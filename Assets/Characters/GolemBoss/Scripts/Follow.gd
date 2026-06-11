extends State

func enter():
	super.enter()
	owner.can_move = true
	animation_player.play("idle")

func exit():
	super.exit()
	owner.can_move = false

func transition():
	var distance = owner.direction.length()
	var horizontal_distance = abs(owner.direction.x)
	 
	if distance > 0 and horizontal_distance < 30:
		get_parent().change_state("MeleeAttack")
	elif distance > 130:
		get_parent().change_state("LaserBeam")
 
