extends Popup

export(String) var title = 'Title'
export(Array, PackedScene) var buttons = []

onready var label = $CenterContainer/VBoxContainer/Label
onready var vbox = $CenterContainer/VBoxContainer

func _on_reset_level():
	visible = false

func _ready():
	label.text = title
	for button in buttons:
		vbox.add_child( button.instance() )
		
