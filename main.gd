extends Node

onready var world = $World
onready var gui = $Gui

func _ready():
	call_deferred("init")

func init():
	gui.load_gui('menu')

func _process(delta):
	if Input.is_action_just_pressed("ui_pause"):
		get_tree().paused = !get_tree().paused
