extends Control

var reset_timer = null

onready var pause_popup = $Pause
onready var win_popup = $Win
onready var timer = $timer
onready var tips = $Tips

func _on_pause(val):
	pause_popup.visible = val
	
func _process(delta):
	if reset_timer:
		timer.text = String( stepify(reset_timer.time_left,1.0) )

func _on_level_win():
	win_popup.visible = true

func _on_reset_timer_start(reset):
	reset_timer = reset
	
func _on_zero_players_connected():
	tips.show_message('respawn')
	
func _on_some_players_connected():
	tips.hide()
