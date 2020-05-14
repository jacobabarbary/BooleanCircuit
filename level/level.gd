extends Node2D

onready var players = $Players
onready var camera = $Camera


func _ready():
	camera.targets = get_players()
	camera.set_current(true)

func get_players()->Node2D:
	return players.get_children()
