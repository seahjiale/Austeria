extends Node

var respawn_position: Vector2 = Vector2.ZERO
var selected_class: CharacterClassData = null
var equipped_weapon: WeaponData = null
var current_area: String = ''
var music_volume: float = 9.0


func reset():
	respawn_position = Vector2.ZERO
