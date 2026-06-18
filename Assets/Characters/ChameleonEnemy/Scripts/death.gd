extends State

func enter():
	super.enter()
	owner.find_child("ChameleonEnemySprite").play("Death")
	
func exit():
	super.exit()
	
func transition():
	pass
