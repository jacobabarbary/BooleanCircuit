extends Control

onready var pause_popup = $Pause
onready var win_popup = $Win
onready var tips = $Tips

func _on_pause(val):
	pause_popup.visible = val
	
func _on_level_win():
	win_popup.visible = true
	
func _on_zero_players_connected():
	tips.show_message('respawn')
	
func _on_some_players_connected():
	tips.hide()
