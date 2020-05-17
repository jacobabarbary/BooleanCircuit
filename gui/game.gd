extends Control

var reset_timer = null

onready var pause_popup = $Pause
onready var death_popup = $Death
onready var timer = $timer


func _process(delta):
	if reset_timer:
		print( stepify(reset_timer.time_left,0.1) )
		timer.text = String( stepify(reset_timer.time_left,1.0) )
	pause_popup.visible = get_tree().paused


func _on_all_players_disconnected():
	death_popup.visible = true

func _on_reset_timer_start(reset):
	reset_timer = reset
	
