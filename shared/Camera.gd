extends Node2D

const MIN_ZOOM = 0.8
const ZOOM_SCALE_OFFSET = 0.003

var zoom: float = 1
var sum: Vector2 = Vector2.ZERO

export(Array) var targets: Array

onready var camera = $Camera


func _process(delta):
	_position()
	_zoom()


func _zoom():
	zoom = max( MIN_ZOOM , max_target_distance() * ZOOM_SCALE_OFFSET )
	camera.zoom = Vector2(zoom, zoom)
	
func _position():
	sum.x 
	for targ in targets:
		sum += targ.position

	position = sum / targets.size()
	
	sum = Vector2.ZERO



func max_target_distance():
	return targets.min().position.distance_to(targets.max().position)

func set_current(val: bool):
	camera.current = val

