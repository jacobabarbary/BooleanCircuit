extends Control

onready var pause_popup = $Pause
onready var death_popup = $Death



func _process(delta):
	pause_popup.visible = get_tree().paused



func _on_all_players_disconnected():
	death_popup.visible = true
