extends StaticBody2D

onready var collider = $CollisionShape2D
onready var sprite = $Sprite
onready var scene_root = get_tree().current_scene
var type = 1

func _process(delta):
	
	if typeof(scene_root.types[type]) == TYPE_BOOL:
		if scene_root.types[type] == true:
			collider.disabled = true
			sprite.visible = false
	else:
		collider.disabled = false
		sprite.visible = true
