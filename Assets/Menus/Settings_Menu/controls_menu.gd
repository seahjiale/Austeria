extends Panel

@export var hover_offset: float = 4.0
@export var label_offset_x: float = -4.0
@export var hover_duration: float = 0.1

var original_positions := {}
var original_label2_offsets := {} 
var original_label_positions := {}  


const CONTROLS_SAVE = "user://controls.cfg"


var action_map = {
	"Left": "move_left",
	"Right": "move_right", 
	"Attack": "attack",
	"Jump": "jump",
	"Interact": "interact",
	"Inventory": "inventory",
	"Skillbook": "open_skill_book"
}
var listening_for: String = ""
var listening_label: Label = null

func _ready():
	$Left.pressed.connect(_on_remap_pressed.bind("move_left", $Left/Label2))
	$Right.pressed.connect(_on_remap_pressed.bind("move_right", $Right/Label2))
	$Attack.pressed.connect(_on_remap_pressed.bind("attack", $Attack/Label2))
	$Jump.pressed.connect(_on_remap_pressed.bind("jump", $Jump/Label2))
	$Interact.pressed.connect(_on_remap_pressed.bind("interact", $Interact/Label2))
	$Inventory.pressed.connect(_on_remap_pressed.bind("inventory", $Inventory/Label2))
	$Skillbook.pressed.connect(_on_remap_pressed.bind("open_skill_book", $Skillbook/Label2))

	for btn_name in ["Left", "Right", "Attack", "Jump", "Interact", "Inventory", "Skillbook"]:
		var btn = get_node(btn_name)
		var label2 = btn.get_node("Label2")
		var label = btn.get_node("Label")
		original_positions[btn] = btn.position
		original_label2_offsets[label2] = Vector2(label2.offset_left, label2.offset_top)
		original_label_positions[label] = label.position
		btn.mouse_entered.connect(func(): _on_button_hover(btn, label2, label))
		btn.mouse_exited.connect(func(): _on_button_unhover(btn, label2, label))

	load_controls()
	update_all_key_labels()

func _on_button_hover(btn: BaseButton, label2: Label, label: Label) -> void:
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(btn, "position:y", original_positions[btn].y + hover_offset, hover_duration)
	tween.tween_property(label2, "offset_left", original_label2_offsets[label2].x + label_offset_x, hover_duration)
	tween.tween_property(label2, "offset_top", original_label2_offsets[label2].y + hover_offset, hover_duration)
	tween.tween_property(label, "position:x", original_label_positions[label].x + label_offset_x, hover_duration)
	tween.tween_property(label, "position:y", original_label_positions[label].y + hover_offset, hover_duration)

func _on_button_unhover(btn: BaseButton, label2: Label, label: Label) -> void:
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(btn, "position:y", original_positions[btn].y, hover_duration)
	tween.tween_property(label2, "offset_left", original_label2_offsets[label2].x, hover_duration)
	tween.tween_property(label2, "offset_top", original_label2_offsets[label2].y, hover_duration)
	tween.tween_property(label, "position:x", original_label_positions[label].x, hover_duration)
	tween.tween_property(label, "position:y", original_label_positions[label].y, hover_duration)

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
	$Interact/Label2.text = "Current Key: " + get_key_name("interact")
	$Inventory/Label2.text = "Current Key: " + get_key_name("inventory")
	$Skillbook/Label2.text = "Current Key: " + get_key_name("open_skill_book")

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
