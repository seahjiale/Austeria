extends State

func enter():
	super.enter()
	owner.can_move = false
	var sprite = owner.find_child("ChameleonEnemySprite")
	sprite.play("Attack")
	await sprite.animation_finished
	get_parent().change_state("Idle")
	
func exit():
	super.exit()
	owner.disable_tongue_hitbox()
	
func transition():
	pass
