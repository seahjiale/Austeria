extends CharacterBody2D

@export var weapon_drops: Dictionary = {
	"Warrior": preload("res://Assets/Characters/Classes/Warrior/GolemSwordPickup.tscn"),
	"Archer": preload("res://Assets/Characters/Classes/Archer/GolemBowPickup.tscn")
}

@onready var sprite = $GolemSprite
@onready var player = get_tree().get_first_node_in_group("player")
@onready var progress_bar = $UI/ProgressBar
const SPEED = 300
var direction : Vector2
var DEF = 0
var can_move: bool = false:
	set(value):
		can_move = value
 
var health = 30:
	set(value):
		health = value
		progress_bar.value = value
		if value <= 0:
			progress_bar.visible = false
			$Hitbox.set_deferred("disabled", true)
			find_child("FiniteStateMachine").change_state("Death")
			drop_weapon()

func _ready():
	progress_bar.max_value = health
	progress_bar.value = health
 
func _process(_delta):
	if player == null:
		player = get_tree().get_first_node_in_group("player")
		return
	direction = player.global_position - global_position
	if direction.x < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
 
func _physics_process(delta):
	if not can_move:
		return
	if not is_on_floor():
		velocity.y += get_gravity().y * delta
	velocity.x = direction.normalized().x * 40
	move_and_slide()
 
func take_damage(amount: int):
	health -= amount - DEF
	
func drop_weapon():
	if player == null or player.current_class == null:
		return
	var className = player.get_current_class().className
	var weapon_scene = weapon_drops.get(className, null)
	if weapon_scene == null:

		return
	var weapon_instance = weapon_scene.instantiate()
	weapon_instance.global_position = global_position
	get_parent().add_child(weapon_instance)
