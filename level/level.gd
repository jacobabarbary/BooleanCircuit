extends Node2D

enum {X_O,PLUS_MINUS,KEY_LOCK}

var types = [X_O,PLUS_MINUS,KEY_LOCK]
var players_connected = 0

onready var players = $Players
onready var camera = $Camera
onready var world = get_parent()

func _ready():
	camera.targets = get_players()
	camera.set_current(true)

func _on_player_disconnected(player):
	players_connected += -1
	_player_connections()

func _on_player_connected(player):
	players_connected += 1
	_player_connections()
	
func _player_connections():
	if world:
		if players_connected < 1:
			world._on_zero_players_connected()
		else:
			world._on_some_players_connected()




func get_players()->Node2D:
	return players.get_children()

func on_triggered(type,triggered):
	
	
	get_tree().call_group("door","_on_door_open",type,triggered)
	types[type] = triggered
	
