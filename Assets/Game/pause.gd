extends Node

@onready var pause_menu: Panel = %PauseMenu
@onready var ui: CanvasLayer = $".."

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	
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


func _on_resume_button_pressed() -> void:
	pause_menu.hide()
	get_tree().paused = false
	
