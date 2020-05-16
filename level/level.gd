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

func on_whats_connected(type,triggered):
	
	types[type] = triggered
	print(types,type,triggered)
