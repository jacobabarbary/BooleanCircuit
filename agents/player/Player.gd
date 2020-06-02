extends RigidBody2D

const MAX_SPEED = 1000
const DISCONNECTED_COLOR = Color.white

export(int) var player_friction = 0.1

var profile: Node = Profiles.get_default()
var rot_speed = 0.1
var speed = 150
var charge = 1
var CHARGE_SPEED = speed / 2

onready var body = $Pivot/Skins/Body
onready var connector = $Connector
onready var pivot = $Pivot
onready var thrust = $AnimThrust
onready var skins = $Pivot/Skins
onready var input = $PlayerInput

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
	
func _on_profile_updated(new_profile):
	set_color(profile.color)
	set_skin(profile.skin)

func _on_PlayerInput_release_key(hold_time):
	if connector.ray_connected:
		launch()



func _aim(delta):
	if input.is_pressed:
		pivot.rotate(rot_speed)
		charge += (CHARGE_SPEED * delta)

func _friction(delta):
	linear_velocity = linear_velocity - linear_velocity * 0.9 * delta

func launch():
	linear_velocity += Vector2(0,1).rotated(pivot.rotation) * min(MAX_SPEED, speed + charge)
	rot_speed = -rot_speed
	charge = 1
	
	thrust.play("%d" % ( randi()%7+1 ))
	thrust.queue("idle")



func set_color(col: Color)->void:
	if connector.ray_connected:
		body.modulate = col

func set_skin(index)->void:
	for sprite in skins.get_children():
		sprite.set_frame(index)
