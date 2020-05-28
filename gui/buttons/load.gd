extends Button

export(String, 'MAIN', 'GUI') var path_type 
export(String) var val

func _on_button_pressed():
	Global.load_by_path_type(path_type, val)
