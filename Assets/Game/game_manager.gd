extends Node

@onready var game_over_ui: Panel = $"../UI/GameOver/GameOverMenu"
@export var hearts : Array[Node]

var points = 0
var lives = 3
var game_over = false

func _ready() -> void:
	$"../UI".show()

# handles health logic and health UI
func decrease_health():
	lives -= 1
	for h in 3:
		if (h < lives):
			hearts[h].show()
		else:
			hearts[h].hide()
	
	if lives <= 0:
		trigger_game_over()
		
func trigger_game_over():
	if game_over:
		return
	game_over = true
	game_over_ui.show()
	get_tree().paused = true
