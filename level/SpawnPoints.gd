extends Node2D

onready var player_box = get_node('../Players')
onready var spawn_points = get_children()

signal spawn_player(player)
signal all_players_spawned()

var spawn_index = 0

func _ready():
	call_deferred('_init')
	
func _init():
	if get_child_count() > 0:
		for profile in Profiles.get_players():
			add_player(profile.get_player())
			
	emit_signal("all_players_spawned")
	
func add_player(player):
	player.position = get_spawn_position()
	emit_signal("spawn_player", player)

func get_spawn_position():
	spawn_index += 1
	if not spawn_index < get_child_count():
		spawn_index = 0
	return get_children()[spawn_index].position

