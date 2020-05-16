extends Node2D

var nearby: Array = []
var connection = null
var last_connection
export var is_powered = false

onready var line = $Line
onready var hitbox = $HitBox
onready var detectbox = $DetectBox

signal connection_changed(val)

func _physics_process(delta): 
	test_connection()
	update_line()
#	if not connection == null:
#		if not is_connected("is_connected",connection.get_parent(),"on_connected"):
#			connect("is_connected",connection.get_parent(),"on_connected")

func _on_DetectBox_area_entered(area):
	update_nearby()
	_connection()

func _on_DetectBox_area_exited(area):
	update_nearby([area])
	_connection()

func _connection():
	try_new_connection()
	
	emit_signal("connection_changed",has_connection())

func test_connection():
#	TODO: break the connection if a wall is between the two connectors
	pass 

func try_new_connection(area = null):
	reset_connection()
	var space_state = get_world_2d().direct_space_state
	for targ in nearby:
		if can_connect(space_state, targ):	
			set_connection( targ.get_parent() )
			return

func update_line()->void:
	if has_connection():
		line.points = [Vector2.ZERO, connection.global_position - global_position]

func update_nearby(exclusion: Array = []):
	nearby = detectbox.get_overlapping_areas()
	exclusion.append(hitbox)
	for exclude in exclusion:
		nearby.erase(exclude)

func reset_connection()->void:
	connection = null
	line.visible = false

func set_connection(connector)->void:
	connection = connector
	line.visible = true

func can_connect(space_state, targ)->bool:
	return not space_state.intersect_ray(
		global_position, targ.global_position, 
		[self], detectbox.collision_mask
	)

func has_connection()->bool:
	return connection != null
