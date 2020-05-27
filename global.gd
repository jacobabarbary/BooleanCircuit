extends Node

const GUI_PATH = 'res://gui/%s.tscn'
const LEVEL_PATH = 'res://level/level_%d.tscn'
const MAX_LEVELS = 4

var lvl_num = 1
var current_scene = null

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)

func load_gui(gui_name: String):
	call_deferred("_deferred_goto_scene", GUI_PATH % gui_name)

func load_level(new_lvl_number: int):
	lvl_num = new_lvl_number
	call_deferred("_deferred_goto_scene", "res://game.tscn")

func reset_level():
	load_level(lvl_num)

func end_game():
	load_gui('menu')
	
func next_level():
	if lvl_num < MAX_LEVELS:
		lvl_num += 1
		load_level(lvl_num)
	else:
		lvl_num = 1
		end_game()
		
func _deferred_goto_scene(path):
	print('woop')
	# It is now safe to remove the current scene
	current_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	current_scene = s.instance()

	# Add it to the active scene, as child of root.
	get_tree().get_root().add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene() API.
	get_tree().set_current_scene(current_scene)

