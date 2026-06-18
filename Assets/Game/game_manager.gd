extends Node

@onready var game_over_ui: Panel = $"../UI/GameOver/GameOverMenu"
@onready var hearts = $"../UI/Hearts/HBoxContainer".get_children()
var points = 0
var lives = 3
var game_over = false

func _ready() -> void:
	$"../UI".show()
	# updating hearts after class selection
	if GameState.selected_class != null:
		lives = GameState.selected_class.max_health
	update_hearts()

func update_hearts():
	for i in range(hearts.size()):
		hearts[i].visible = i < lives

# handles health logic and health UI
func decrease_health():
	lives -= 1
	update_hearts()
	if lives <= 0:
		trigger_game_over()
		
func trigger_game_over():
	if game_over:
		return
	game_over = true
	game_over_ui.show()
	get_tree().paused = true
