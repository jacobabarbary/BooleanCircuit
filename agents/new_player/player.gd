extends KinematicBody2D

var inputs = ["PlayerAction","Player2Action"]
export var player_number = 1

var velocity = Vector2()
var charge = 0.0
const charge_speed = 0.2
var rot_speed = 0.14
var speed = 10
const FRICTION = 0.99


func _launch():
	
	if Input.is_action_just_released(inputs[player_number]):
		velocity = Vector2(0,speed).rotated(rotation) * charge
		charge = 0


func _charge_up():
	
	if Input.is_action_pressed(inputs[player_number]):
		charge += charge_speed
		rotate(rot_speed)
	else:
		rotate(-rot_speed)


func _physics_process(delta):
	
	_charge_up()
	_launch()
	velocity = velocity * FRICTION
	move_and_slide(velocity)
