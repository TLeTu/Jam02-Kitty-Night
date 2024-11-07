extends Node

@export var _initialState : State
var _states : Dictionary = {}
var _currentState : State 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is State:
			_states[child.name.to_lower()] = child
			child._transitioned.connect(OnChildTransitioned)
	if _initialState:
		_initialState.Enter()
		_currentState = _initialState
	else:
		_currentState = get_child(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if _currentState:
		_currentState.Update(delta)
	

func _physics_process(delta: float) -> void:
	if _currentState:
		_currentState.PhysicsUpdate(delta)

func OnChildTransitioned(state, nextStateName):
	if state != _currentState:
		return
	
	var nextState = _states.get(nextStateName.to_lower())
	if !nextState:
		return
	
	nextState.Enter()
	_currentState = nextState

func _get_current_state():
	return _currentState
