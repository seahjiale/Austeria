extends State

@export var fireball_scene: PackedScene = preload("res://Assets/Characters/FlyingDemonEnemy/Fireball.tscn")
@onready var fireball_spawn_point = $"../../FireballSpawn"
@onready var game_manager = get_tree().get_first_node_in_group("GameManager")
var can_transition: bool = false

func enter():
	super.enter()
	can_transition = false
	owner.can_move = false
	animation_player.play("Attack")
	await animation_player.animation_finished
	can_transition = true
	get_parent().change_state("Flying")

func _shoot_fireball():
	var fireball = fireball_scene.instantiate()
	get_tree().current_scene.add_child(fireball)
	fireball.global_position = fireball_spawn_point.global_position
	var dir = (owner.player.global_position - fireball_spawn_point.global_position).normalized()
	fireball.setup(dir)

func transition():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
