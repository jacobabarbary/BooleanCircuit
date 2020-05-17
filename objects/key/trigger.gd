extends Node2D

export var type = 0

func _on_Connector_connected():
	get_tree().call_group("Door","_on_door_open",type)


func _on_Connector_disconnected():
	get_tree().call_group("Door","_on_door_close",type)
