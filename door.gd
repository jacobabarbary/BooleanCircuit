extends StaticBody2D

onready var collider = $CollisionShape2D
onready var sprite = $Sprite
onready var scene_root = get_tree().current_scene
export var door_type = 1

func on_triggered(type,triggered):
	
	if type == door_type and triggered == true:
		collider.disabled = true
		sprite.visible = false
	else:
		collider.disabled = false
		sprite.visible = true
	
	print(type,triggered)
