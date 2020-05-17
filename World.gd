extends Node

const LEVEL_PATH = 'res://level/level_%d.tscn'
const MAX_LEVELS = 1


var lvl_num: int = 1

func _on_reset_level():
	load_level(lvl_num)

func _on_start_level(num):
	load_level(num)

func _on_end_game():
	remove_current_level()

func _on_next_level():
	if lvl_num < MAX_LEVELS:
		lvl_num += 1
	else:
		lvl_num = 1
	load_level(lvl_num)


func load_level(num: int):
	remove_current_level()
	add_new_level(num)

func add_new_level(num: int):
	var lvl = load(LEVEL_PATH % num).instance()
	add_child(lvl)

func remove_current_level():
	if has_node('Level'):
		var lvl = get_node('Level')
		remove_child(lvl)
		lvl.queue_free()


