extends Node

onready var world = $World
onready var gui = $Gui

func _ready():
	call_deferred("init")

func init():
	gui.load_gui('menu')

