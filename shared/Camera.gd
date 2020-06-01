extends Node2D

const MIN_ZOOM = 0.7

const ZOOM_SCALE_OFFSET = 0.002

const ZOOM_RATIO = Vector2(0, 0)

var zoom: float = 1

var center: Vector2 = Vector2.ZERO
var max_corner: Vector2 = Vector2.ZERO
var min_corner: Vector2 = Vector2.ZERO
var boundary_size: Vector2 = Vector2.ZERO


export(Array) var targets: Array

onready var screen = get_viewport().size
onready var camera = $Camera


func _process(delta):
	update()
	
	if !targets.empty():
		_math()
		_position()
		_zoom()

func _zoom():
	zoom = get_zoom()
	camera.zoom = Vector2(zoom, zoom)
	
func _position():
	position = center


func _math():	
	min_corner = center
	max_corner = center
	center = Vector2.ZERO
	
	for targ in targets:
		center += targ.position
		max_corner.x = max( targ.position.x, max_corner.x )
		max_corner.y = max( targ.position.y, max_corner.y )
		min_corner.x = min( min_corner.x, targ.position.x )
		min_corner.y = min( min_corner.y, targ.position.y )

	center = center / targets.size()


func get_zoom()->float:
	boundary_size = (max_corner - min_corner)

	return max( ( max( boundary_size.x, boundary_size.y 
			) ) * ZOOM_SCALE_OFFSET , MIN_ZOOM )


func set_current(val: bool):
	camera.current = val

