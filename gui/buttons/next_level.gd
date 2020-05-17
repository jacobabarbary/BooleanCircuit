extends Button

func _on_LevelNext_pressed():
	get_tree().call_group("LevelNext", "_on_next_level")
