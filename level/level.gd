extends Node2D

enum {X_O,PLUS_MINUS,KEY_LOCK}

var types = [X_O,PLUS_MINUS,KEY_LOCK]


onready var players = $Players
onready var camera = $Camera

func _ready():
	camera.targets = get_players()
	camera.set_current(true)

func get_players()->Node2D:
	return players.get_children()

func on_triggered(type,triggered):
	
	
	get_tree().call_group("door","_on_door_open",type,triggered)
	types[type] = triggered
