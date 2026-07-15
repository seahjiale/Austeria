extends Node

@onready var pause_menu: Panel = %PauseMenu
@onready var ui: CanvasLayer = $".."
@onready var save_button = $PauseMenu/SaveGameButton

const SAVE_FILE = "user://save_game.json"

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	save_button.pressed.connect(_on_save_button_pressed)
	
func _process(_delta):
	var esc_pressed = Input.is_action_just_pressed("Pause")
	if (esc_pressed == true):
		if (pause_menu.visible):
			get_tree().paused = false
			pause_menu.hide()
		else:
			get_tree().paused = true
			pause_menu.show()

func _on_back_to_main_menu_button_pressed() -> void:
	pause_menu.hide()
	ui.hide()
	get_tree().paused = false
	SceneTransition.transition_to("res://Assets/Menus/Main_Menu/main_menu.tscn")

func _on_save_button_pressed() -> void:
	var save_data = {
		"current_area": GameState.current_area,
		"respawn_position": {
			"x": GameState.respawn_position.x,
			"y": GameState.respawn_position.y
		},
		"selected_class": GameState.selected_class.resource_path if GameState.selected_class else "",
		"equipped_weapon": GameState.equipped_weapon.resource_path if GameState.equipped_weapon else ""
	}
	var file := FileAccess.open(SAVE_FILE, FileAccess.WRITE)
	if file == null:
		print("Failed to save")
		return
	file.store_string(JSON.stringify(save_data))
	file.close()
	print("Game saved!")

func _on_resume_button_pressed() -> void:
	pause_menu.hide()
	get_tree().paused = false
	
