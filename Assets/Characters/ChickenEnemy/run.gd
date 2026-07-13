extends State

func enter():
	super.enter()
	owner.can_move = true
	owner.sprite.play("Run")
	call_deferred("_start_timer")

func exit():
	super.exit()

func _start_timer():
	owner.timer.start()
