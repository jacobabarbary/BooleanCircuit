extends Position2D

export(int) var speed: int = 50
export(bool) var is_gui = false
export(float) var rotation_speed = 0.1
# TODO onready disable or enable this camera
var direction = Vector2(1, 0)


func _process(delta):
	position += direction * speed * delta
	direction = direction.rotated(rotation_speed * delta)
