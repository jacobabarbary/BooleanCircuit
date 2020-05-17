extends Button

func _on_LoadGui_pressed():
	get_tree().call_group("GameEnder", "_on_end_game")
