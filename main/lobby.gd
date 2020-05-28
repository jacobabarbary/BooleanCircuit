extends Node

const HOLD_TIME = 1

var events_times = {}
var events = {}

func _process(delta):
	for key in events_times.keys():
		events_times[key] += delta
		if events_times[key] > HOLD_TIME:
			add_player_by_event_id(key)


func _input(event):
	match event.get_class():
		'InputEventJoypadButton':
			_join(event, String(event.button_index))
		'InputEventKey':
			_join(event, String(event.scancode))


func _join(event, event_id):
	if event.is_action_type() && !event_has_an_action(event):
		if event.is_pressed():
			if not events.has(event_id):
				print('joining?')
				events_times[event_id] = 0
				events[event_id] = event
		else:
			print('nope!')
			reset_event_time(event_id)


func reset_event_time(event_id):
	events.erase(event_id)
	events_times.erase(event_id)


func add_player_by_event_id(key):
	print('yup!')
	Profiles.add_player(events[key])
	reset_event_time(key)


func event_has_an_action(event):
	for action in InputMap.get_actions():
		if InputMap.event_is_action(event, action):
			return true

