extends State

func _enter_tree():
	randomize()

func enter():
	super.enter()
	owner.can_move = true
	animation_player.play("Idle")

func exit():
	super.exit()
	owner.can_move = false

func transition():
	var distance = owner.direction.length()
	var horizontal_distance = abs(owner.direction.x)
	 
	if distance > 0 and horizontal_distance < 40:
		get_parent().change_state("Attack")
	if distance > 140:
		var chance = randi() % 2
		match chance:
			0:
				get_parent().change_state("SpawnMinion")
			1:
				get_parent().change_state("Teleport")
