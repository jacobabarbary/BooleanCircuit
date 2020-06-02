extends Node

const MAX_LEVELS = 5

const PATHS = { 
		'GUI' : 'res://gui/%s.tscn',
		'MAIN' : 'res://main/%s.tscn',
		'LEVEL' : 'res://level/level_%d.tscn',
		'ROOT' : 'res://%s.tscn',
		'LOBBY' : 'res://lobby/%s.tscn',
		'PLAYER' : 'res://agents/player/Player.tscn'
	}

var lvl_num = 5
var current_scene = null



func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)



func load_by_path_type(path_type, val = null):

	if path_type == 'LEVEL':
		val = int(val)
		set_lvl_num(val)
	
	call_deferred("_deferred_goto_scene", PATHS[path_type] % val)

func load_gui(gui_name: String):
	load_scene(PATHS['GUI'] % gui_name)

func load_lobby():
	pass
	
func load_level(new_lvl_number: int):
	set_lvl_num(new_lvl_number)	
	load_scene( PATHS['MAIN'] % 'game')

func load_scene(path: String):
	call_deferred("_deferred_goto_scene", path)




func _deferred_goto_scene(path):
	print(path)
	current_scene.free()

	var s = ResourceLoader.load(path)

	current_scene = s.instance()

	get_tree().get_root().add_child(current_scene)

	get_tree().set_current_scene(current_scene)



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


func random_color()->Color:
	randomize()
	return Color.from_hsv(
		rand_range(0,1), 
		rand_range(0.6,1),
		1)
		

func get_level(num = lvl_num):
	return load(PATHS['LEVEL'] % num).instance()

func get_player_icon():
	return load(PATHS['LOBBY'] % 'PlayerIcon').instance()
	
func get_player():
	return load(PATHS['PLAYER']).instance()

func set_lvl_num(val: int)->void:
	if val > 0 && val <= MAX_LEVELS:
		lvl_num = val
