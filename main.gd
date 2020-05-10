extends Node2D

onready var positive = $Positive

func _input(event):
	if event is InputEventMouseMotion:
		positive.set_position(event.position)
		
