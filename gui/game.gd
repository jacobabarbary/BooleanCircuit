extends Control

onready var pause_popup = $Pause
onready var death_popup = $Death



func _process(delta):
	if Input.is_action_just_pressed("ui_pause"):
		pause_popup.visible = !pause_popup.visible

func _on_all_players_disconnected():
	death_popup.visible = true
