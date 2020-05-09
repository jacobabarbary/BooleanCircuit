extends Node2D

export var tag: String = "@"

func _ready():
	set_tag(tag)

func set_tag(val: String):
	$Tag.text = tag
