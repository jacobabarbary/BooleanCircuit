extends Position2D

export(int) var speed: int = 20

func _process(delta):
	position.x += speed * delta
	position.y += speed * delta
