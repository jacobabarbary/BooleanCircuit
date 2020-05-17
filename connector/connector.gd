extends Node2D

var nearby: Array = []
var connection = null
var ray_was_connected = null
var ray_connected = null

export var is_powered = false

onready var line = $Line
onready var hitbox = $HitBox
onready var detectbox = $DetectBox

signal connection_changed(val)
signal connected()
signal disconnected()

func _physics_process(delta): 
	test_connection()
	update_line()
	print(ray_connected)

func _on_DetectBox_area_entered(area):
	update_nearby()
	_connection()

func _on_DetectBox_area_exited(area):
	update_nearby([area])
	_connection()

func _connection():
	try_new_connection()
	ray_connected = has_connection()
	_ray_connection_signals()
	ray_was_connected = has_connection()

func _ray_connection_signals()->void:
	if ray_connected != ray_was_connected || ray_was_connected == null:
		emit_signal("connection_changed",ray_connected)
		if ray_connected:
			emit_signal("connected")
		else:
			emit_signal("disconnected")

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
