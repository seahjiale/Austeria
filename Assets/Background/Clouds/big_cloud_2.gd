extends Sprite2D
@export var scroll_speed = 50.0
var image_width : float
var fixed_y : float

func _ready():
	image_width = texture.get_width() * scale.x
	fixed_y = global_position.y

func _process(delta):
	position.x -= scroll_speed * delta
	if position.x <= 0:
		position.x = image_width
		position.y = fixed_y
