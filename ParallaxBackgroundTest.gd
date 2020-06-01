extends ParallaxBackground

export(int) var speed: int = 1000
export(float) var rotation_speed = 0.4

var direction = Vector2(1, 0)

func _process(delta):
	scroll_offset += direction * speed * delta
	direction = direction.rotated(rotation_speed * delta)

