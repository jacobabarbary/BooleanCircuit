extends Popup

#export(String, FILE, "*.json") var msg_file
export(String, MULTILINE) var text: String = ""
export(Dictionary) var messages

onready var label = $CenterContainer/Label

func show_message(key):
	if not messages.has(key): 
		return
		
	visible = true
	label.text = messages[key]
	
func hide():
	visible = false
	
#func _messages():
#	 var msgs = File.new()
#	 file.open("user://panelText.json", file.READ)
#	 var text = file.get_as_text()
#	 dict.parse_json(text)
#	 file.close()
