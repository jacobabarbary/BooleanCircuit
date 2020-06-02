extends Area2D

var flag_data = []

func _on_Area2D_body_entered(body):
	flag_data = [body,self]
