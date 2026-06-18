extends State

func enter():
	super.enter()

	var sprite = owner.find_child("ChameleonEnemySprite")
	sprite.play("Death")
	await sprite.animation_finished
	owner.queue_free()

func exit():
	super.exit()
	
func transition():
	pass
