extends Node

const RESET_TIME_LIMIT = 1

onready var world = $World
onready var gui = $Gui
onready var global = get_node('/root/Global')
onready var reset = $Reset


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
#		tree.paused = !tree.paused
	if Input.is_action_just_pressed('ui_reset'):
		start_reset_timer()
	elif Input.is_action_just_released('ui_reset'):
		stop_reset_timer()


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


func _on_Reset_timeout():
	Global.reset_level()

func stop_reset_timer():
	reset.start(RESET_TIME_LIMIT)
	reset.set_paused(true)
	get_tree().call_group("ResetTimer","_on_reset_timer_stop", reset)
	
func start_reset_timer():
	reset.start(RESET_TIME_LIMIT)
	reset.set_paused(false)
	get_tree().call_group("ResetTimer","_on_reset_timer_start", reset)	
