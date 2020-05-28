extends Node

const ICON_FORMAT = 'PlayerIcon%d'

export(Color) var color: Color
export(int) var devise: int
export(String) var action: String
export(int) var player_id: int

func get_icon():
	var player_icon = Global.get_player_icon()
	player_icon.modulate = color
	player_icon.name = ICON_FORMAT % player_id
	player_icon.profile = self
	return player_icon

func get_player():
	var player = Global.get_player()
	player.color = color
	player.name = name
	player.profile = self
	return player
