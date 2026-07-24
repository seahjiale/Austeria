extends Node2D

@onready var MovingText = $MovingText/Label
@onready var JumpingText = $JumpingText/Label
@onready var AttackText = $AttackText/Label
@onready var InventorySkillText = $InventoryAndSkillText/Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MovingText.text = get_key_name("move_left") + " to move left\n" + get_key_name("move_right") + " to move right"
	JumpingText.text = get_key_name("jump") + " to jump"
	AttackText.text = get_key_name("attack") + " to attack"

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
	return "F"
