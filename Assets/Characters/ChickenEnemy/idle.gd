extends State

func enter():
	super.enter()
	owner.can_move = false
	owner.sprite.play("Idle")
	await owner.get_tree().create_timer(2.0).timeout
	if owner.is_dead:
		return
	get_parent().change_state("Run")

func exit():
	super.exit()
	owner.direction *= -1
	owner.sprite.flip_h = !owner.sprite.flip_h
