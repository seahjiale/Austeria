extends State

func enter():
	super.enter()
	owner.find_child("ChameleonEnemySprite").play("Run")
	owner.can_move = true
	
func exit():
	super.exit()
	owner.can_move = false
	
func transition():
	var distance = owner.direction.length()
	var horizontal_distance = abs(owner.direction.x)

	if distance > 0 and horizontal_distance < 30:
		get_parent().change_state("Attack")
