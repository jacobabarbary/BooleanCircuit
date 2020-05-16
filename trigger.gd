extends Node2D

export var type = 0
var triggered = false
onready var connector = $Connector

signal whats_connected

func _ready():
	connect("whats_connected",get_parent(),"on_whats_connected")

func _process(delta):
	if connector.has_connection():
		triggered = true
	else:
		triggered = false
	emit_signal("whats_connected",type,triggered)
