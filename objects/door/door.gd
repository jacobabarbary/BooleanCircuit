extends StaticBody2D


const DISABLED_COLOR = Color(0.5,0.5,0.5,0.3)
const ENABLED_COLOR = Color(1,0.5,0.5,1)

export var door_type = 1


onready var collider = $CollisionShape2D
onready var sprite = $Sprite
onready var scene_root = get_tree().current_scene


func on_triggered(type,triggered):
	
	if type == door_type and triggered == true:
		collider.disabled = true
		sprite.modulate = DISABLED_COLOR
	else:
		collider.disabled = false
		sprite.modulate = ENABLED_COLOR
		sprite.visible = true

