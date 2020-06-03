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

func _physics_process(_delta): 
	_test_connection()
	update_line()

func _on_DetectBox_area_entered(_area):
	update_nearby()
	_connection()

func _on_DetectBox_area_exited(area):
	update_nearby([area])
	_connection()

func _connection():
	reset_connection()
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

func _test_connection():
	if connection:
		var space_state = get_world_2d().direct_space_state
		if not can_connect(space_state, connection):
			_connection()
	elif not nearby.empty():
		_connection()

func try_new_connection():
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
	if connector.connection == self:
		connector.line.visible = true
		line.visible = false
	else:
		line.visible = true

func can_connect(space_state, targ)->bool:
#	if not targ.is_inside_tree():
#		return false
	return not space_state.intersect_ray(
		global_position, targ.global_position, 
		[self], detectbox.collision_mask
	)

func has_connection()->bool:
	return connection != null
