extends Button

export(String) var gui_name = 'menu'

func _on_LoadGui_pressed():
	Global.load_gui(gui_name)
