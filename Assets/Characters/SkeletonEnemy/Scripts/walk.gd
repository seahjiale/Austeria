extends State

func enter():
	super.enter()
	animation_player.play("Walk")

func exit():
	super.exit()

func transition():
	var distance = owner.direction.length()
	var horizontal_distance = abs(owner.direction.x)
	 
	if distance > 0 and horizontal_distance < 30:
		get_parent().change_state("Attack")
