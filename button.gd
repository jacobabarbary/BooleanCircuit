extends Button

export var ChageSceneTo = ""

func _on_play_pressed():
	get_tree().change_scene(ChageSceneTo)
