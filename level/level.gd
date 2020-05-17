extends Node2D

enum {X_O,PLUS_MINUS,KEY_LOCK}

var types = [X_O,PLUS_MINUS,KEY_LOCK]
var players_connected = {}

onready var players = $Players
onready var camera = $Camera
onready var world = get_parent()

func _ready():
	camera.targets = get_players()
	camera.set_current(true)
	world._on_some_players_connected()

func _on_player_disconnected(player):
	players_connected.erase(player.name)
	_player_connections()

func _on_player_connected(player):
	players_connected[player.name] = player
	_player_connections()
	
func _player_connections():
	if world:
		if players_connected.size() < 1:
			world._on_zero_players_connected()
		else:
			world._on_some_players_connected()


func get_players()->Node2D:
	return players.get_children()

	
	
