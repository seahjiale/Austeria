extends Control
class_name SaveMenu

@onready var save_file_1_button = $SaveFile1Button
@onready var save_label = $SaveFile1Button/Label
@onready var delete_button = $DeleteSaveButton
@onready var new_game_button = $NewSaveButton
const SAVE_FILE = "user://save_game.json"

func _ready():
	save_file_1_button.pressed.connect(_on_load_pressed)
	delete_button.pressed.connect(_on_delete_pressed)
	new_game_button.pressed.connect(_on_new_game_pressed)
	_update_button_text()

func _update_button_text() -> void:
	print("checking save file exists: ", FileAccess.file_exists(SAVE_FILE))
	if not FileAccess.file_exists(SAVE_FILE):
		print("no save file, setting label")
		save_label.text = "No Save File"
		return    
	var file := FileAccess.open(SAVE_FILE, FileAccess.READ)  
	var save_data = JSON.parse_string(file.get_as_text())
	file.close()  
	print("save data: ", save_data) 
	if save_data == null:
		save_label.text = "No Save File"
		return   
	var class_name_text = save_data.get("selected_class", "").get_file().get_basename()
	var area_text = save_data.get("current_area", "").get_file().get_basename()
	print("setting label to: ", "%s | %s" % [class_name_text, area_text])
	save_label.text = "%s | %s" % [class_name_text, area_text]

func _on_delete_pressed() -> void:
	DirAccess.remove_absolute(SAVE_FILE)
	print("Save file deleted")
	_update_button_text()

func _on_new_game_pressed() -> void:
	GameState.reset()
	SceneTransition.transition_to("res://Assets/Menus/class_menu/class_menu.tscn")

func _on_load_pressed() -> void:
	var file := FileAccess.open(SAVE_FILE, FileAccess.READ)
	if file == null:
		print("No save file found")
		return
	var text := file.get_as_text()
	file.close()
	var save_data = JSON.parse_string(text)
	if save_data == null:
		print("Failed to parse save file")
		return
	print("Loaded save data: ", save_data)
	_apply_save_data(save_data)

func _apply_save_data(save_data: Dictionary) -> void:
	if save_data.has("current_area"):
		GameState.current_area = save_data.current_area
	if save_data.has("player_position"):
		GameState.load_position = Vector2(
		save_data.player_position.x,
		save_data.player_position.y)
	if save_data.has("selected_class") and save_data.selected_class != "":
		GameState.selected_class = load(save_data.selected_class)
	if save_data.has("equipped_weapon") and save_data.equipped_weapon != "":
		GameState.equipped_weapon = load(save_data.equipped_weapon)
	if save_data.has("unlocked_skills"):
		SkillManager.unlocked_skills = save_data.unlocked_skills
	if save_data.has("skill_points"):
		SkillManager.skill_points = save_data.skill_points
	if save_data.has("equipped_skills"):
		for i in save_data.equipped_skills.size():
			var path = save_data.equipped_skills[i]
			if path != "":
				SkillManager.equip_skill(i, load(path))
			else:
				SkillManager.unequip_skill(i)
	if save_data.has("lives"):
		GameState.current_health = save_data.lives
	if save_data.has("level"):
		ExpManager.level = save_data.level
		ExpManager.xp_to_next = ExpManager._xp_for_level(ExpManager.level)
	if save_data.has("current_xp"):
		ExpManager.current_xp = save_data.current_xp
	SceneTransition.transition_to(GameState.current_area)
