extends Node

const MENU_PATH = 'res://gui/%s.tscn'


func _on_start_level(num):
	load_gui('game')

func _on_gui_change(gui_name):
	load_gui(gui_name)
	
func _on_end_game():
	load_gui('menu')


func load_gui(file_name: String):
	remove_current_gui()
	add_new_gui(file_name)

func add_new_gui(file_name: String):
	var gui = load(MENU_PATH % file_name).instance()
	add_child(gui)

func remove_current_gui():
	if has_node('Gui'):
		var gui = get_node('Gui')
		remove_child(gui)
		gui.queue_free()
