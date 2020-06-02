extends Node


onready var world = $World
onready var gui = $Gui
onready var global = get_node('/root/Global')


var players_connected = {}


func _ready():
	call_deferred("init")

func init():
	var lvl = Global.get_level()
	add_child(lvl)


func _process(delta):
	if Input.is_action_just_pressed("ui_pause"):
		var tree = get_tree()
		get_tree().call_group("Pause","_on_pause", !tree.paused)


func _on_player_disconnected(player):
	players_connected.erase(player.name)
	_player_connections()

func _on_player_connected(player):
	players_connected[player.name] = player
	_player_connections()
	
func _player_connections():
	if players_connected.size() < 1:
		get_tree().call_group("PlayerConnections","_on_zero_players_connected")
	else:
		get_tree().call_group("PlayerConnections","_on_some_players_connected")

func _on_zero_players_connected():
	print("zero")
	
func _on_some_players_connected():
	print("some")

