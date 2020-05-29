extends RigidBody2D

const MAX_SPEED = 1000
const DISCONNECTED_COLOR = Color.gray


enum POLARITIES { POSITIVE, NEGITIVE }


export(int) var player_friction = 0.1

var profile: Node = Profiles.get_default()
var inputs_pressed = [null, null, null]
var inputs = ["PlayerAction","Player2Action"]
var rot_speed = 0.1
var speed = 150
var charge = 1
var CHARGE_SPEED = speed / 2

onready var sprite = $Sprite
onready var connector = $Connector

func _ready():
	set_skin(profile.skin)
	set_color(profile.color)

func _process(delta):
	inputs_pressed = [
		Input.is_action_pressed(profile.action),
		Input.is_action_just_released(profile.action),
		Input.is_action_just_pressed(profile.action)]


func _physics_process(delta):
	if connector.ray_connected:
		aim(delta)
		launch()
		
	_friction(delta)

func _friction(delta):
	linear_velocity = linear_velocity - linear_velocity * 0.9 * delta


func aim(delta):
	if inputs_pressed[0]:
		sprite.rotate(rot_speed)
		charge += (CHARGE_SPEED * delta)

func launch():
	if inputs_pressed[1]:
		linear_velocity += Vector2(0,1).rotated(sprite.rotation) * min(MAX_SPEED, speed + charge)
		rot_speed = -rot_speed
		charge = 1

func set_color(col: Color)->void:
	if connector.ray_connected:
		sprite.modulate = col

func set_skin(index)->void:
	sprite.set_frame(index)

func _on_Connector_connected():
	sprite.modulate = profile.color
	get_tree().call_group("PlayerConnections","_on_player_connected", self)

func _on_Connector_disconnected():
	sprite.modulate = DISCONNECTED_COLOR
	get_tree().call_group("PlayerConnections","_on_player_disconnected", self)
	
func _on_profile_updated(new_profile):
	set_color(profile.color)
	set_skin(profile.skin)
