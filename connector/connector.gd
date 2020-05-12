extends Node2D

var target = null
var nearby: Array = []
var connection = null
var collider = null


onready var ray = $Ray
onready var line = $Line

func _physics_process(delta):
	draw_connection()

func try_connection(area = null):
	connection = null
	line.visible = false
	nearby = $DetectBox.get_overlapping_areas()

		
	for targ in nearby:
		
		if targ != area && targ != $HitBox:
			print("targ ", targ.name)

#			TODO: handle raycast correctly
#				i think you will need to use a snapshot.

			connection = targ.get_parent()
			line.visible = true
			return



func draw_connection()->void:
	if connection != null:
		line.points = [Vector2.ZERO, connection.global_position - global_position]
		$Sprite.modulate = Color.red
	else:
		$Sprite.modulate = Color.blue

func _on_DetectBox_area_entered(area):
	try_connection()

func _on_DetectBox_area_exited(area):
	try_connection(area)


