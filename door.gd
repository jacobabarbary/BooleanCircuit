extends StaticBody2D

onready var collider = $CollisionShape2D
onready var sprite = $Sprite
var type = 0

func _process(delta):
	
	if get_parent().types[type] == true:
		collider.disabled = true
		sprite.visible = false
	else:
		collider.disabled = false
		sprite.visible = true
