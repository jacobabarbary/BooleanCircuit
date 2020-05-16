extends RigidBody2D

enum POLARITIES { POSITIVE, NEGITIVE }

onready var sprite = $Sprite
onready var connector = $Connector

var inputs_pressed = [null, null, null]
var inputs = ["PlayerAction","Player2Action"]
var ray_connected

export(int, 
	"#", 'o', '-', 'yen' , '^', 'x' , '+', 'yang', 'sad', 'happy', 'eyes', 'skull'
	) var skin = 0 setget set_skin
	
export(Color) var color = Color.white
export(int) var player_friction = 0.1
export(int, "PlayerAction","Player2Action") var player_number = 1

var rot_speed = 0.1
var speed = 250
var charge = 1


func _ready():
	set_skin(skin)
	set_color(color)
	

func _process(delta):
	inputs_pressed = [
		Input.is_action_pressed(inputs[player_number]),
		Input.is_action_just_released(inputs[player_number]),
		Input.is_action_just_pressed(inputs[player_number])]


func _physics_process(delta):
	aim()
	launch()
	_friction(delta)

func _friction(delta):
	linear_velocity = linear_velocity * 0.99
#	add_central_force( -(linear_velocity * 0.5 * delta))
	
func aim():
	if inputs_pressed[0]:
		sprite.rotate(rot_speed)

func launch():
	if inputs_pressed[1]:
		linear_velocity += Vector2(0,1).rotated(sprite.rotation) * speed
		rot_speed = -rot_speed

func set_color(col: Color)->void:
	color = col
	sprite.modulate = col

func set_skin(index)->void:
	skin = index
	$Sprite.set_frame(index)

func _on_ray_connected(is_ray_connected)->void:
	ray_connected = is_ray_connected
