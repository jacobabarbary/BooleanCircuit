extends Node

const RESET_TIME_LIMIT = 1

onready var world = $World
onready var gui = $Gui
onready var global = get_node('/root/Global')
onready var reset = $Reset

func _ready():
	call_deferred("init")


func init():
	var lvl = load(global.LEVEL_PATH % global.lvl_num).instance()
	add_child(lvl)

func _process(delta):
	if Input.is_action_just_pressed("ui_pause"):
		var tree = get_tree()
		get_tree().call_group("Pause","_on_pause", !tree.paused)
#		tree.paused = !tree.paused
	if Input.is_action_just_pressed('ui_reset'):
		start_reset_timer()
	elif Input.is_action_just_released('ui_reset'):
		stop_reset_timer()

func _on_Reset_timeout():
	Global.reset_level()

func stop_reset_timer():
	reset.start(RESET_TIME_LIMIT)
	reset.set_paused(true)
	get_tree().call_group("ResetTimer","_on_reset_timer_stop", reset)
	
func start_reset_timer():
	reset.start(RESET_TIME_LIMIT)
	reset.set_paused(false)
	get_tree().call_group("ResetTimer","_on_reset_timer_start", reset)	
