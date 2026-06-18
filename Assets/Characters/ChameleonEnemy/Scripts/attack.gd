extends State

func enter():
	super.enter()
	owner.can_move = false
	owner.enable_tongue_hitbox()
	
	var sprite = owner.find_child("ChameleonEnemySprite")
	sprite.play("Attack")
	await sprite.animation_finished
	owner.start_attack_cooldown()
	get_parent().change_state("Idle")
	
func exit():
	super.exit()
	owner.disable_tongue_hitbox()
	
func transition():
	pass
