extends Node2D

onready var timer = $Timer

func _on_Connector_connected():
	timer.start(1)

func _on_Timer_timeout():
	get_tree().call_group("Win","_on_level_win")
