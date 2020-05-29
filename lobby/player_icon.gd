extends TextureRect

var profile: Node = Profiles.get_default()

signal remove_player_input(profile)

func _ready():
	$PlayerInput.profile = profile


func _on_profile_updated(new_profile):
	modulate = profile.color


func _on_PlayerInput_pressed_key():
	pass # Replace with function body.


func _on_PlayerInput_release_held_key(hold_time):
	print('held released')


func _on_PlayerInput_release_tapped_key(hold_time):
	print('tap')
	profile.randomize_style()


func _on_PlayerInput_holding_key():
	emit_signal('remove_player_input', self)
