extends Node2D

var MAX_DIST = 200

var target = null
onready var ray = $Ray


func _on_DetectBox_area_entered(area):
	cast_ray(area.global_position)
	var thing = ray.get_collider()
	if thing:
		print(thing.name)
	
#	print("keys", target.name)

func cast_ray(pos: Vector2)->void:
	ray.cast_to = ( pos - global_position ).normalized() * MAX_DIST

func _on_DetectBox_area_exited(area):
	target = null


