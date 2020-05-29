extends Node2D

enum {X_O,PLUS_MINUS,KEY_LOCK}

var types = [X_O,PLUS_MINUS,KEY_LOCK]

onready var players = $Players
onready var camera = $Camera


func _ready():
	camera.set_current(true)

func get_players()->Node2D:
	return players.get_children()

func _on_SpawnPoints_spawn_player(player):
	players.add_child(player)

func _on_SpawnPoints_all_players_spawned():
	camera.targets = get_players()
