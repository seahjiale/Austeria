extends Node2D

var current_state: State
var previous_state: State

func _ready():
	current_state = get_child(0) as State
	previous_state = current_state
	current_state.enter()

func change_state(state):
	previous_state = current_state
	previous_state.exit()        # exit old state first
	current_state = find_child(state, false) as State
	current_state.enter()   
