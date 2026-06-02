extends Node

@onready var level_label  = $VBoxContainer/HBoxContainer/LevelLabel
@onready var xp_label     = $VBoxContainer/HBoxContainer/EXPLabel
@onready var xp_bar       = $VBoxContainer/EXPBar
@onready var levelup_anim = $VBoxContainer/LevelUpAnimation

func _ready() -> void:
	ExpManager.connect("xp_changed", _on_xp_changed)
	ExpManager.connect("level_changed", _on_level_changed)
	_refresh_ui()

func _on_xp_changed(current, required) -> void:
	xp_bar.value = float(current) / float(required) * 100.0
	xp_label.text = "%d / %d XP" % [current, required]

func _on_level_changed(new_level) -> void:
	level_label.text = "LV %d" % new_level
	levelup_anim.play("level_up_flash")

func _refresh_ui() -> void:
	level_label.text = "LV %d" % ExpManager.level
	xp_label.text    = "%d / %d XP" % [
		ExpManager.current_xp,
		ExpManager.xp_to_next
	]
	xp_bar.value = ExpManager.get_xp_percent() * 100.0
