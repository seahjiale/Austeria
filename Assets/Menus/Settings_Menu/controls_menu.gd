extends Panel
# map button names to action names
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
	update_all_key_labels()

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
				MOUSE_BUTTON_LEFT:
					return "Left Click"
				MOUSE_BUTTON_RIGHT:
					return "Right Click"
				MOUSE_BUTTON_MIDDLE:
					return "Middle Click"
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
		update_all_key_labels()
		listening_for = ""
		get_viewport().set_input_as_handled()
	elif event is InputEventMouseButton and event.pressed:
		var mouse_event = InputEventMouseButton.new()
		mouse_event.button_index = event.button_index
		mouse_event.pressed = true
		InputMap.action_erase_events(listening_for)
		InputMap.action_add_event(listening_for, mouse_event)
		var button_label = null
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				button_label = "Left Click"
			MOUSE_BUTTON_RIGHT:
				button_label = "Right Click"
			MOUSE_BUTTON_MIDDLE:
				button_label = "Middle Click"
		if button_label != null:
			listening_label.text = button_label
		update_all_key_labels()
		listening_for = ""
		get_viewport().set_input_as_handled()
