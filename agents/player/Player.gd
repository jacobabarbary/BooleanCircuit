extends RigidBody2D

const MAX_SPEED = 1000
const DISCONNECTED_COLOR = Color.gray

enum POLARITIES { POSITIVE, NEGITIVE }

export(int, "#", 'o', '-', 'yen' , '^', 'x' , '+', 
	'yang', 'sad', 'happy', 'eyes', 'skull' ) var skin = 0 setget set_skin
	
export(Color) var color = Color.white
export(int) var player_friction = 0.1
export(int, "PlayerAction","Player2Action") var player_number = 1

var inputs_pressed = [null, null, null]
var inputs = ["PlayerAction","Player2Action"]
var rot_speed = 0.1
var speed = 300
var charge = 1

onready var sprite = $Sprite
onready var connector = $Connector

func _ready():
	set_skin(skin)
	set_color(color)
	connector.connect("is_connected",self,"_on_connected", ["is_ray_connected"])

func _process(delta):
	inputs_pressed = [
		Input.is_action_pressed(inputs[player_number]),
		Input.is_action_just_released(inputs[player_number]),
		Input.is_action_just_pressed(inputs[player_number])]


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
		charge += (100 * delta)

func launch():
	if inputs_pressed[1]:
		linear_velocity += Vector2(0,1).rotated(sprite.rotation) * min(MAX_SPEED, speed + charge)
		rot_speed = -rot_speed
		charge = 1

func set_color(col: Color)->void:
	color = col
	sprite.modulate = col

func set_skin(index)->void:
	skin = index
	$Sprite.set_frame(index)

func _on_Connector_connected():
	$Sprite.modulate = color

func _on_Connector_disconnected():
	$Sprite.modulate = DISCONNECTED_COLOR
