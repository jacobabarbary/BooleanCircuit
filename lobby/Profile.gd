extends Node

const ICON_FORMAT = 'PlayerIcon%d'
const MAX_SKIN_COUNT = 11

export(Color) var color: Color
export(int) var devise: int
export(String) var action: String
export(int) var player_id: int
export(int, "#", 'o', '-', 'yen' , '^', 'x' , '+', 
	'yang', 'sad', 'happy', 'eyes', 'skull' ) var skin = 0


func get_icon():
	var player_icon = Global.get_player_icon()
	player_icon.modulate = color
	player_icon.name = ICON_FORMAT % player_id
	player_icon.profile = self
	return player_icon

func get_player():
	var player = Global.get_player()
	player.name = name
	player.profile = self
	return player
	
func random_style():
	color = Global.random_color()
	skin = randi()%MAX_SKIN_COUNT
	print(skin)

func randomize_style():
	random_style()
	get_tree().call_group('PlayerProfile', '_on_profile_updated', self)

