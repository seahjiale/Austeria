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
	var players = get_tree().get_nodes_in_group("player")
	var player = players[0] if players.size() > 0 else null    
	if player == null:
		print("Player not found, cannot save position")
		return
	var equipped_skill_ids = []
	for skill in SkillManager.equipped_slots:
		if skill != null:
			equipped_skill_ids.append(skill.resource_path)
		else:
			equipped_skill_ids.append("")
	var save_data = {
		"current_area": GameState.current_area,
		"player_position": {
			"x": player.global_position.x,
			"y": player.global_position.y},
		"selected_class": GameState.selected_class.resource_path if GameState.selected_class else "",
		"equipped_weapon": GameState.equipped_weapon.resource_path if GameState.equipped_weapon else "",
		"equipped_skills": equipped_skill_ids,
		"unlocked_skills": SkillManager.unlocked_skills,
		"skill_points": SkillManager.skill_points,
		"lives": get_tree().current_scene.get_node("%GameManager").lives,
		"level": ExpManager.level,
		"current_xp": ExpManager.current_xp  
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
	
