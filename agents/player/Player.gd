extends KinematicBody2D

enum POLARITIES { POSITIVE, NEGITIVE }
const charge_speed = 20
const FRICTION = 0.99

var inputs = ["PlayerAction","Player2Action"]

export(Texture) var positive_texture
export(Texture) var negative_texture
export(POLARITIES) var polaraty = POLARITIES.POSITIVE
export var player_number = 1

var velocity = Vector2()
var charge = 0.0
var rot_speed = 7
var speed = 10

onready var sprite = $Sprite
onready var connector = $Connector

func _ready():
	connector.polaraty = polaraty
	match polaraty:
		POLARITIES.POSITIVE:
			sprite.texture = positive_texture
		POLARITIES.NEGITIVE:
			sprite.texture = negative_texture


func _launch():
	
	if Input.is_action_just_released(inputs[player_number]):
		velocity = Vector2(0,speed).rotated(sprite.rotation) * charge
		charge = 0


func _charge_up(delta):
	
	if Input.is_action_pressed(inputs[player_number]):
		charge += charge_speed
		sprite.rotate(rot_speed * delta)
	else:
		sprite.rotate(-rot_speed * delta)


func _physics_process(delta):
	
	_charge_up(delta)
	_launch()
	velocity = velocity * FRICTION
	move_and_slide(velocity * delta)
