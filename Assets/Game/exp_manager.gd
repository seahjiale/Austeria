extends Node

signal xp_changed(current_xp, required_xp)
signal level_changed(new_level)

var level: int = 1
var current_xp: int = 0
var xp_to_next: int = 100

# XP curve where more exp is required as you level up : base * (level ^ exponent)
const BASE_XP = 100
const XP_EXPONENT = 1.5

func _ready() -> void:
	xp_to_next = _xp_for_level(level)

func gain_xp(amount: int) -> void:
	current_xp += amount
	while current_xp >= xp_to_next:
		current_xp -= xp_to_next
		level += 1
		xp_to_next = _xp_for_level(level)
		emit_signal("level_changed", level)
	emit_signal("xp_changed", current_xp, xp_to_next)

func _xp_for_level(lv: int) -> int:
	return int(BASE_XP * pow(lv, XP_EXPONENT))

func get_xp_percent() -> float:
	return float(current_xp) / float(xp_to_next)

func reset():
	level = 1
	current_xp = 0
	xp_to_next = _xp_for_level(level)
