extends Node

onready var world = $World
onready var gui = $Gui

func _ready():
	call_deferred("init")

func init():
	gui.load_gui('menu')

func _process(delta):
	if Input.is_action_just_pressed("ui_pause"):
		var tree = get_tree()
		get_tree().call_group("Pause","_on_pause", !tree.paused)
		tree.paused = !tree.paused

func _on_level_win():
	get_tree().paused = true
