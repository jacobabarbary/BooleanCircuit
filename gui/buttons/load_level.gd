extends Button

export(int) var lvl_num = 1

func _on_LoadLevel_pressed():
	Global.load_level(lvl_num)
