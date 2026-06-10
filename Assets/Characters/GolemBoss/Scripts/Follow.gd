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
 
	if distance > 0 and distance < 30:
		get_parent().change_state("MeleeAttack")
	elif distance > 130:
		var chance = randi() % 2
		match chance:
			0:
				get_parent().change_state("HomingMissile")
			1:
				get_parent().change_state("LaserBeam")
	
 
