extends TextureRect


var profile = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if profile && event.is_action(profile.action):
		print(profile.name)
