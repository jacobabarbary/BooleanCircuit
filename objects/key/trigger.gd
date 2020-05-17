extends Node2D

onready var connector = $Connector
export var type = 0
var triggered


func _physics_process(delta):
	triggered = connector.ray_connected
	get_tree().call_group("triggered","on_triggered",type,triggered)
