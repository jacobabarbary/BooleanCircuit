extends Node

const HOLD_TIME = 1

var events_times = {}
var events = {}

onready var icon_box = $CanvasLayer/Control/VBoxContainer/CenterContainer/IconBox
onready var player_box = $Room/Players

func _process(delta):
	_event_timers(delta)

func _event_timers(delta):
	for key in events_times.keys():
		events_times[key] += delta
		if events_times[key] > HOLD_TIME:
			_create_player(key)

func _create_player(key):
	print('yup!')
#	TODO: replace this print with a signal or something for a display.

#	TODO: make a display / popup for player joining

	var player_profile = Profiles.add_player(events[key])
	
	_init_player(player_profile)

	clear_event_timer(key)

func _on_SpawnPoints_spawn_player(player):
	_init_player(player.profile)

func _init_player(player_profile):
	icon_box.add_child(player_profile.get_icon())
	player_box.add_child(player_profile.get_player())
	icon_box.get_node(player_profile.name).connect(
		'remove_player_input', self, "_remove_player")

func _remove_player(player_icon: Node):
	player_icon.disconnect('remove_player_input', self, "_remove_player")
	icon_box.get_node(player_icon.name).queue_free()
	player_box.get_node(player_icon.name).queue_free()
	Profiles.remove_player(player_icon.profile)
	
func _input(event):
	match event.get_class():
		'InputEventJoypadButton':
			_join(event, event.button_index)
		'InputEventKey':
			_join(event, event.as_text())


func _join(event, event_id):
	if event.is_action_type() && !event_has_an_action(event):
		if event.is_pressed():
			if not events.has(event_id):
				print('joining?')
				start_event_timer(event, event_id)
#				TODO: replace this print with a signal or something for a display.
		else:
			print('nope!')
#			TODO: replace this print with a signal or something for a display.
			clear_event_timer(event_id)


func start_event_timer(event, event_id):
	events_times[event_id] = 0
	events[event_id] = event

func clear_event_timer(event_id):
	events.erase(event_id)
	events_times.erase(event_id)


func event_has_an_action(event):
	for action in InputMap.get_actions():
		if InputMap.event_is_action(event, action):
			return true




