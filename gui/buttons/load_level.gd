extends Button

export(int) var lvl_num = 1

func _on_LoadLevel_pressed():
	get_tree().call_group("LevelStarter", "_on_start_level", lvl_num)
