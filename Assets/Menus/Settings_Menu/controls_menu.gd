extends Panel

const CONTROLS_SAVE = "user://controls.cfg"

var action_map = {
	"Left": "move_left",
	"Right": "move_right", 
	"Attack": "attack",
	"Jump": "jump"
}
var listening_for: String = ""
var listening_label: Label = null

func _ready():
	$Left/Label.text = "LEFT"
	$Right/Label.text = "RIGHT"
	$Attack/Label.text = "ATTACK"
	$Jump/Label.text = "JUMP"   
	$Left.pressed.connect(_on_remap_pressed.bind("move_left", $Left/Label2))
	$Right.pressed.connect(_on_remap_pressed.bind("move_right", $Right/Label2))
	$Attack.pressed.connect(_on_remap_pressed.bind("attack", $Attack/Label2))
	$Jump.pressed.connect(_on_remap_pressed.bind("jump", $Jump/Label2))    
	load_controls()
	update_all_key_labels()

func save_controls() -> void:
	var config = ConfigFile.new()
	for action in action_map.values():
		var events = InputMap.action_get_events(action)
		for event in events:
			if event is InputEventKey:
				config.set_value("controls", action, {
					"type": "key",
					"keycode": event.physical_keycode})
			elif event is InputEventMouseButton:
				config.set_value("controls", action, {
					"type": "mouse",
					"button_index": event.button_index})
	config.save(CONTROLS_SAVE)

func load_controls() -> void:
	var config = ConfigFile.new()
	if config.load(CONTROLS_SAVE) != OK:
		return  # no saved controls, use defaults
	for action in action_map.values():
		if not config.has_section_key("controls", action):
			continue
		var data = config.get_value("controls", action)
		InputMap.action_erase_events(action)
		if data.type == "key":
			var event = InputEventKey.new()
			event.physical_keycode = data.keycode
			InputMap.action_add_event(action, event)
		elif data.type == "mouse":
			var event = InputEventMouseButton.new()
			event.button_index = data.button_index
			event.pressed = true
			InputMap.action_add_event(action, event)

func update_all_key_labels():
	$Left/Label2.text = "Current Key: " + get_key_name("move_left")
	$Right/Label2.text = "Current Key: " + get_key_name("move_right")
	$Attack/Label2.text = "Current Key: " + get_key_name("attack")
	$Jump/Label2.text = "Current Key: " + get_key_name("jump")

func get_key_name(action: String) -> String:
	var events = InputMap.action_get_events(action)
	for event in events:
		if event is InputEventKey:
			return event.as_text_physical_keycode()
		elif event is InputEventMouseButton:
			match event.button_index:
				MOUSE_BUTTON_LEFT: return "Left Click"
				MOUSE_BUTTON_RIGHT: return "Right Click"
				MOUSE_BUTTON_MIDDLE: return "Middle Click"
	return "None"

func _on_remap_pressed(action: String, label: Label):
	listening_for = action
	listening_label = label
	label.text = "Press a key..."

func _input(event: InputEvent):
	if listening_for == "":
		return
	if event is InputEventKey and event.pressed:
		InputMap.action_erase_events(listening_for)
		InputMap.action_add_event(listening_for, event)
		save_controls()
		update_all_key_labels()
		listening_for = ""
		get_viewport().set_input_as_handled()
	elif event is InputEventMouseButton and event.pressed:
		var mouse_event = InputEventMouseButton.new()
		mouse_event.button_index = event.button_index
		mouse_event.pressed = true
		InputMap.action_erase_events(listening_for)
		InputMap.action_add_event(listening_for, mouse_event)
		save_controls()  # save after every remap
		update_all_key_labels()
		listening_for = ""
		get_viewport().set_input_as_handled()
