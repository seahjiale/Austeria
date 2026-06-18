extends Node

@onready var game_over: Panel = %GameOverMenu
@onready var ui: CanvasLayer = $".."

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func _on_back_to_main_menu_button_pressed() -> void:
	ui.hide()
	game_over.hide()
	get_tree().paused = false
	ui.call_deferred("queue_free")
	SceneTransition.transition_to("res://Assets/Menus/Main_Menu/main_menu.tscn")

func _on_restart_button_pressed() -> void:
	ui.hide()
	game_over.hide()
	get_tree().paused = false
	GameState.reset()
	ExpManager.reset()
	SceneTransition.transition_to("res://Assets/Levels/Area1/area_1.tscn")
