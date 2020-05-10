extends KinematicBody2D

enum POLARITIES { POSITIVE, NEGITIVE }

const MAX_CHARGE = 10
const MIN_SPEED = 6000
const charge_speed = 2
const FRICTION = 0.99

var inputs = ["PlayerAction","Player2Action"]

export(Texture) var positive_texture
export(Texture) var negative_texture
export(POLARITIES) var polaraty = POLARITIES.POSITIVE
export var player_number = 1

var velocity = Vector2()
var charge = 0
var rot_speed = 2
var speed = MIN_SPEED

onready var sprite = $Sprite
onready var connector = $Connector

func _ready():
	connector.polaraty = polaraty
	match polaraty:
		POLARITIES.POSITIVE:
			sprite.texture = positive_texture
		POLARITIES.NEGITIVE:
			sprite.texture = negative_texture


func _physics_process(delta):
	_launch()
	_charge_up(delta)
	
	sprite.rotate( input_rotation() * delta )
	move_and_slide( movement() * delta )




func _launch():
	if button_just_released():
		speed = speed * charge
		charge = 0

func _charge_up(delta):
	if button_pressed():
		charge = min( charge + (charge_speed * delta), MAX_CHARGE )



func input_rotation():
	return ( ( int(button_pressed()) *2 ) - 1 ) * rot_speed
	
func movement()->Vector2:
	speed = max( MIN_SPEED, speed * FRICTION)
	return Vector2( 0 , speed ).rotated(sprite.rotation)
	
	
	
func button_pressed()->bool:
	return Input.is_action_pressed(inputs[player_number])
	
func button_just_released()->bool:
	return Input.is_action_just_released(inputs[player_number])





