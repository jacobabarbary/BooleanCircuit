extends TextureRect

const TAP = 0.15
const HOLD = 2

var profile: Node = Profiles.get_default()
var held = -1

func _process(delta):
	if held > -1:
		held += delta

func _input(event):
	if event.is_action_pressed(profile.action):
		held = 0
	elif event.is_action_released(profile.action):
		if held < TAP:
			_tap()
		elif held > HOLD:
			_hold()
		held = -1

func _hold():
	print('held')
#	TODO: emit signal, held so we can remove the player
	
func _tap():
	print('tap')
	profile.randomize_style()

func _on_profile_updated(new_profile):
	modulate = profile.color
	
