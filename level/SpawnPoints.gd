extends Node2D

onready var player_box = get_node('../Players')
onready var spawn_points = get_children()

var spawn_index = 0

func _ready():
	for profile in Profiles.get_players():
		add_player(profile.get_player())

func add_player(player):
	player.position = get_spawn_position()
	player_box.add_child(player)

func get_spawn_position():
	spawn_index += 1
	if not spawn_index < spawn_points.size():
		spawn_index = 0
	return spawn_points[spawn_index].position

