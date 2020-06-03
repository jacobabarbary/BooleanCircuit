extends Node

const PLAYER_PATH = 'res://lobby/player.tscn'
const NAME_FORMAT = "player%d"

var players = []
var player_num = 2


onready var player = load(PLAYER_PATH)

func remove_player(player_to_remove):
	if get_child_count() > 1:
		InputMap.erase_action(player_to_remove.action)
		player_to_remove.queue_free()

func add_player(event):
	player_num += 1
	var action_name = NAME_FORMAT % player_num
	InputMap.add_action(action_name)
	InputMap.action_add_event(action_name , event)
	return new(event.get_device(), action_name)


func new(devise_index: int, new_action: String):
	var new_player = player.instance()

	new_player.devise = devise_index
	new_player.action = new_action
	new_player.name = NAME_FORMAT % player_num
	new_player.player_id = player_num	
	new_player.random_style()

	add_child(new_player)
	return get_node(new_player.name)


func get_default():
	return get_children()[0]

func get_players():
	return get_children()


