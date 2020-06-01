extends Node

export(int) var speed: int = 50
export(float) var rotation_speed: float = 0.1

var direction = Vector2(1, 0)

onready var parallax = $Parallax

func _process(delta):
	parallax.scroll_offset += direction * speed * delta
	direction = direction.rotated(rotation_speed * delta)
