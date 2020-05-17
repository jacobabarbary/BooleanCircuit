extends Node

const LEVEL_PATH = 'res://level/level_%d.tscn'
const MAX_LEVELS = 2
const RESET_TIME_LIMIT = 6

var lvl_num: int = 1

onready var reset = $Reset

func _ready():
	stop_reset_timer()


func _on_zero_players_connected():
	start_reset_timer()
	
func _on_some_players_connected():
	stop_reset_timer()

func _on_Reset_timeout():
	stop_reset_timer()
	_on_reset_level()


	
func _on_reset_level():
	load_level(lvl_num)

func _on_start_level(num):
	lvl_num = num
	load_level(num)

func _on_end_game():
	remove_current_level()

func _on_next_level():
	if lvl_num < MAX_LEVELS:
		lvl_num += 1
	else:
		lvl_num = 1
	load_level(lvl_num)




func stop_reset_timer():
	reset.start(RESET_TIME_LIMIT)
	reset.set_paused(true)
	get_tree().call_group("ResetTimer","_on_reset_timer_stop", reset)
	
func start_reset_timer():
	reset.start(RESET_TIME_LIMIT)
	reset.set_paused(false)
	get_tree().call_group("ResetTimer","_on_reset_timer_start", reset)	



func load_level(num: int):
	remove_current_level()
	add_new_level(num)
	get_tree().paused = false

func add_new_level(num: int):
	var lvl = load(LEVEL_PATH % num).instance()
	add_child(lvl)

func remove_current_level():
	stop_reset_timer()
	if has_node('Level'):
		var lvl = get_node('Level')
		remove_child(lvl)
		lvl.queue_free()




