extends State
@onready var detection_area = $"../../PlayerDetection"

func enter():
	set_physics_process(true)
	owner.can_move = false
	animation_player.play("Idle")

func exit():
	set_physics_process(false)
	owner.can_move = true

func transition():
	for body in detection_area.get_overlapping_bodies():
		if body is Node and body.is_in_group("player"):
			get_parent().change_state("Walk")
			return
