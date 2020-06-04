extends RigidBody2D

const MAX_SPEED = 1200
const DISCONNECTED_COLOR = Color.white
var CHARGE_ROT = 0.2

export(int) var player_friction = 0.1

var profile: Node = Profiles.get_default()
var rot = 5
var rot_mod = 1 
var speed = 180
var charge = 1
var is_frozen = false

var checkpoint: Node2D
var BOOST_TIME = 1

onready var body = $Pivot/Skins/Body
onready var connector = $Connector
onready var pivot = $Pivot
onready var thrust = $AnimThrust
onready var skins = $Pivot/Skins
onready var input = $PlayerInput
onready var timeout = $Timeout

func _ready():
	input.profile = profile	
	set_skin(profile.skin)
	set_color(profile.color)


func _physics_process(delta):
	if connector.ray_connected:
		_aim(delta)
	_friction(delta)


func _on_Connector_connected():
	body.modulate = profile.color
	get_tree().call_group("PlayerConnections","_on_player_connected", self)

func _on_Connector_disconnected():
	thrust.queue("idle")
	body.modulate = DISCONNECTED_COLOR
	get_tree().call_group("PlayerConnections","_on_player_disconnected", self)
	
func _on_profile_updated(_new_profile):
	set_color(profile.color)
	set_skin(profile.skin)

func _on_PlayerInput_holding_key():
	if not connector.ray_connected:
		is_frozen = true
		respawn()
	else:
		rot_mod = CHARGE_ROT

func _on_PlayerInput_release_tapped_key(_hold_time):
	_launch()

func _on_PlayerInput_release_pressed_key(_hold_time):
	_launch()

func _on_PlayerInput_release_held_key(_hold_time):
	if not is_frozen:
		_boost()
	else:
		is_frozen = false
	rot_mod = 1


func _on_Timeout_timeout():
	pass # Replace with function body.

func _boost():
	if connector.ray_connected:
		charge = MAX_SPEED

		_launch()
	charge = 1


func _aim(delta):
	if input.is_pressed:
		pivot.rotate(rot * rot_mod * delta)

func _friction(delta):
	linear_velocity = linear_velocity - linear_velocity * 0.9 * delta

func _launch():
	if connector.ray_connected:
		linear_velocity += Vector2(0,1).rotated(pivot.rotation) * min(MAX_SPEED, speed + charge)
		rot = -rot
		
		thrust.play("%d" % ( randi()%7+1 ))
		thrust.queue("idle")


func respawn():
	position = checkpoint.position

func set_color(col: Color)->void:
	if connector.ray_connected:
		body.modulate = col

func set_skin(index)->void:
	for sprite in skins.get_children():
		sprite.set_frame(index)



