class_name StateMachine
extends Node

@export var initial_state : State
var _states : Dictionary = {}
var _current_state : State :
	get = current_state

func _ready() -> void:
	for child in get_children():
		if child is State:
			_states[child.name.to_lower()] = child
			child.transitioned.connect(on_child_transitioned)
	if initial_state:
		initial_state.enter()
		_current_state = initial_state
	else:
		_current_state = get_child(0)

func _process(delta: float) -> void:
	if _current_state:
		_current_state.update(delta)
	

func _physics_process(delta: float) -> void:
	if _current_state:
		_current_state.physics_update(delta)

func on_child_transitioned(state, next_state_name):
	if state.name == next_state_name:
		return
	if state != _current_state:
		return
	
	var next_state = _states.get(next_state_name.to_lower())
	if !next_state:
		return
	_current_state.exit()
	next_state.enter()
	_current_state = next_state

func current_state() -> State:
	return _current_state
