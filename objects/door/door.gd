extends StaticBody2D


const DISABLED_COLOR = Color(0.5,0.5,0.5,0.3)
const ENABLED_COLOR = Color(1,0.5,0.5,1)

export var door_type = 1

onready var collider = $CollisionShape2D
onready var sprite = $Sprite

func _on_door_open(key_type):
	if door_type == key_type:
		collider.disabled = true
		sprite.modulate = DISABLED_COLOR

func _on_door_close(key_type):
	if door_type == key_type:
		collider.disabled = false
		sprite.modulate = ENABLED_COLOR
