extends State
func enter():
	super.enter()
	owner.find_child("ChameleonEnemySprite").play("Idle")
	
func exit():
	super.exit()
	
func transition():
	var distance = owner.direction.length()

	if distance > 0 and owner.direction.x < 0 and owner.direction.x > -50:
		get_parent().change_state("Attack")
