extends Node2D

enum {X_O,PLUS_MINUS,KEY_LOCK}

var types = [X_O,PLUS_MINUS,KEY_LOCK]
var players_connected = {}

onready var players = $Players
onready var camera = $Camera
onready var game = get_node('/root/Game')

func _ready():
	camera.targets = get_players()
	camera.set_current(true)
#	game._on_some_players_connected()

func _on_player_disconnected(player):
	players_connected.erase(player.name)
	_player_connections()

func _on_player_connected(player):
	players_connected[player.name] = player
	_player_connections()
	
func _player_connections():
	return
	if game:
		if players_connected.size() < 1:
			game._on_zero_players_connected()
		else:
			game._on_some_players_connected()


func get_players()->Node2D:
	return players.get_children()

	
	
