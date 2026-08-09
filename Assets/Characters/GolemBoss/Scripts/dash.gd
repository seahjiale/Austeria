extends State
 
var can_transition: bool = false
 
func enter():
	super.enter()
	animation_player.play("glowing")
	await dash()
	can_transition = true
 
func dash():
	var tween = create_tween()
	var target_position = owner.player.position + Vector2(0, -30)
	tween.tween_property(owner, "position", target_position, 0.8)
	await tween.finished
 
func transition():
	if can_transition:
		can_transition = false
 
		get_parent().change_state("Follow")
 
