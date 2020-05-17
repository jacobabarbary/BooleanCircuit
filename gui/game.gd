extends Control

var reset_timer = null

onready var pause_popup = $Pause
onready var win_popup = $Win
onready var timer = $timer

func _on_pause(val):
	pause_popup.visible = val
	
func _process(delta):
	if reset_timer:
		print( stepify(reset_timer.time_left,0.1) )
		timer.text = String( stepify(reset_timer.time_left,1.0) )

func _on_level_win():
	win_popup.visible = true

func _on_all_players_disconnected():
	pass

func _on_reset_timer_start(reset):
	reset_timer = reset
	
