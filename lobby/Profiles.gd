extends Node

const PLAYER_PATH = 'res://lobby/player.tscn'
const NAME_FORMAT = "player%d"
const ACTION_FORMAT = "player%dbtn"


var players = []
var player_num = 0


onready var player = load(PLAYER_PATH)

func remove_player(player_to_remove):
	player_to_remove.queue_free()

func add_player(event):
	player_num += 1
	var action_name = ACTION_FORMAT % player_num
	InputMap.add_action(action_name)
	InputMap.action_add_event(action_name , event)
	return new(event.get_device(), action_name, Global.random_color())


func new(devise_index: int, new_action: String, new_color: Color, skin = 0):
	var new_player = player.instance()

	new_player.devise = devise_index
	new_player.action = new_action
	new_player.name = NAME_FORMAT % player_num
	new_player.player_id = player_num	
	new_player.random_style()

	add_child(new_player)
	return get_node(new_player.name)


func get_default():
	return $Default

func get_players():
	return get_children()


