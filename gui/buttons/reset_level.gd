extends Button

func _on_ResetLevel_pressed():
	get_tree().call_group("LevelReseter", "_on_reset_level")
