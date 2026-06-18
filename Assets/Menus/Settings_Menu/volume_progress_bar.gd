extends TextureProgressBar


func _ready():
	min_value = 0
	max_value = 9
	# initial start at maximum volume
	value = 9
	step = 1
	self.value_changed.connect(_on_value_changed)
	
func _gui_input(event):
	# click to adjust volume
	if event is InputEventMouseButton and event.pressed:
		var click_ratio = event.position.x / size.x
		value = ceil(click_ratio * max_value)
	
	# click and drag to adjust volume
	if event is InputEventMouseMotion and event.button_mask == MOUSE_BUTTON_MASK_LEFT:
		var drag_ratio = clamp(event.position.x / size.x, 0.0, 1.0)
		value = ceil(drag_ratio * max_value)
		
func _on_value_changed(new_value):
	var vol_ratio = new_value / max_value
	var capped_ratio = vol_ratio * 0.6
	AudioServer.set_bus_volume_db(0, linear_to_db(capped_ratio))
