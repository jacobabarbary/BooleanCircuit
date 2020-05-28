extends Node

const PLAYER_PATH = 'res://lobby/player.tscn'
const NAME_FORMAT = "player%d"
const ACTION_FORMAT = "player%dbtn"

var players = []
var player_num = 0

export(Array, Color) var colors = [Color.red]

onready var player = load(PLAYER_PATH)

func _ready():
#	TODO get and save data to json so we can start up with the same players that left
	print(' woop  woo' )

func add_player(event):
	player_num += 1
	var action_name = ACTION_FORMAT % player_num
	InputMap.add_action(action_name)
	InputMap.action_add_event(action_name , event)
	new(event.get_device(), action_name, random_color())

func new(devise_index: int, new_action: String, new_color: Color):
	var new_player = player.instance()
	
	new_player.devise = devise_index
	new_player.action = new_action
	new_player.color = new_color
	new_player.name = NAME_FORMAT % player_num
	
	print(new_player.name)
	
	add_child(new_player)
	

func get_players():
	return get_children()

func random_color()->Color:
	return colors[randi() % colors.size()]
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
