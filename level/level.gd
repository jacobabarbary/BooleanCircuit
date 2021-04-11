extends Node2D

enum {X_O,PLUS_MINUS,KEY_LOCK}
export var level_settings = {"example_setting":true}
var types = [X_O,PLUS_MINUS,KEY_LOCK]

onready var players = $Players
onready var camera = $Camera
onready var camera_objects = $Camera

func _ready():
	camera.set_current(true)

func get_camera_objects():
	return get_tree().get_nodes_in_group('camera_objects')

func _on_SpawnPoints_spawn_player(player):
	players.add_child(player)

func _on_SpawnPoints_all_players_spawned():
	var camera_objects = get_camera_objects()
	for i in camera_objects:
		if "camera_object" in i:
			if i.camera_object:
				camera.targets.append(i)
		else:
			camera.targets.append(i)
