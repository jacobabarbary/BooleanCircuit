extends Node

const TAP = 0.15
const HOLD = 1.5

var profile: Node = Profiles.get_default()
var held = -1
var is_pressed = false


signal pressed_key()
signal holding_key()
signal release_key(hold_time)
signal release_tapped_key(hold_time)
signal release_pressed_key(hold_time)
signal release_held_key(hold_time)


func _process(delta):
	if held > -1:
		held += delta
		if held > HOLD:
			emit_signal("holding_key")

func _input(event):
	if event.is_action_pressed(profile.action):
		held = 0
		emit_signal("pressed_key")
		is_pressed = true
	elif event.is_action_released(profile.action):
		if held < TAP:
			emit_signal("release_tapped_key", held)
		elif held > HOLD:
			emit_signal("release_held_key", held)
		else:
			emit_signal("release_pressed_key", held)
		emit_signal("release_key", held)
		is_pressed = false
		held = -1
