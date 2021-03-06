extends Node

const MAX_SKIN_COUNT = 12

export(Color) var color: Color
export(int) var devise: int
export(String) var action: String
export(int) var player_id: int
export(int, "#", 'o', '-', 'yen' , '^', 'x' , '+', 'yang', 'sad', 'happy', 'eyes', 'skull' ) var skin = 0


func get_icon():
	var player_icon = Global.get_player_icon()
	player_icon.modulate = color
	player_icon.name = name
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

func randomize_style():
	random_style()
	get_tree().call_group('PlayerProfile', '_on_profile_updated', self)

