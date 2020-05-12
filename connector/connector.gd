extends Node2D

var target = null
var connection = null
var collider = null


onready var ray = $Ray
onready var end = $End
onready var line = $Line

func _physics_process(delta):
	if target && !connection:
		
		cast_ray(target.global_position)
		end.global_position = ray.get_collision_point()
		
		collider = ray.get_collider()
		if collider && collider.name == "HitBox":
			connection = target.get_parent()
			line.visible = true
			
	draw_connection()

func draw_connection()->void:
	if connection:
		line.points = [Vector2.ZERO, connection.global_position - global_position]

func _on_DetectBox_area_entered(area):
	target = area

func _on_DetectBox_area_exited(area):
	if area == target:
		target = null
		connection = null
		line.visible = false

func cast_ray(pos: Vector2)->void:
	ray.cast_to = pos - ray.global_position

