extends Node2D

onready var connector = $Connector
export var type = 0
var triggered

signal is_connection

func _ready():
	
	
	
	connect("is_connection",get_tree().current_scene,"on_connection")

func _physics_process(delta):
	triggered = connector.ray_connected
	emit_signal("is_connection",type,triggered)
