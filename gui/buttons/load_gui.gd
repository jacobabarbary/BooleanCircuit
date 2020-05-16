extends Button

export(String) var gui_name = 'menu'

func _on_LoadGui_pressed():
	get_tree().call_group("GuiChanger", "_on_gui_change", gui_name)
