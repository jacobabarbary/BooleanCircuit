extends Node

onready var start = $Start
onready var end = $End
onready var line = $Line

var connected = []

func _process(delta):
	line.points = [start, end]

