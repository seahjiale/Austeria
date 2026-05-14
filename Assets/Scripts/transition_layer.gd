extends CanvasLayer

@onready var color_rect: ColorRect = $ColorRect
var target_scene: String = ""
var duration: float = 0.8

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	color_rect.visible = false

func transition_to(new_scene: String, trans_duration: float = 0.8) -> void:
	target_scene = new_scene
	duration = trans_duration
	_animate_out()

func _animate_out() -> void:
	color_rect.visible = true
	color_rect.material.set_shader_parameter("reverse", false)
	var tween = create_tween()
	tween.tween_method(
		func(v): color_rect.material.set_shader_parameter("progress", v),
		0.0, 1.0, duration)
	tween.finished.connect(_on_out_finished)

func _on_out_finished() -> void:
	get_tree().change_scene_to_file(target_scene)
	_animate_in()

func _animate_in() -> void:
	color_rect.material.set_shader_parameter("reverse", true)
	var tween = create_tween()
	tween.tween_method(
		func(v): color_rect.material.set_shader_parameter("progress", v),
		0.0, 1.0, duration
	)
