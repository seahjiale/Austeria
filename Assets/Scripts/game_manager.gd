extends Node

@export var hearts : Array[Node]

var points = 0
var lives = 3

func _ready() -> void:
	$"../UI".show()
	
func decrease_health():
	lives -= 1
	for h in 3:
		if (h < lives):
			hearts[h].show()
		else:
			hearts[h].hide()
	
	if lives == 0:
		get_tree().call_deferred("reload_current_scene")
