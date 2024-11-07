extends Area2D
class_name VentMonster

@export var _hidingTimer: Timer
@export var _knockingTimer: Timer
@export var _enteringTimer: Timer

var currentState: State

func _ready() -> void:
	if not _hidingTimer:
		_hidingTimer = get_node("Timer/HidingTimer")
	if not _knockingTimer:
		_knockingTimer = get_node("Timer/KnockingTimer")
	if not _enteringTimer:
		_enteringTimer = get_node("Timer/EnteringTimer")

func _process(delta: float) -> void:
	currentState = get_node("StateMachine")._get_current_state()
	if currentState.get_name() == "Hiding" and _hidingTimer.is_stopped():
		_hidingTimer.start(5)
	if currentState.get_name() == "Knocking" and _knockingTimer.is_stopped():
		_knockingTimer.start(5)
	if currentState.get_name() == "Entering" and _enteringTimer.is_stopped():
		_enteringTimer.start(5)

func _on_area_entered(area: Area2D) -> void:
	print(currentState.get_name())
	if currentState.get_name() == "Knocking":
		print("Pushed monster back")
		currentState._transitioned.emit(currentState, "Hiding")
		_knockingTimer.stop()
	if currentState.get_name() == "Entering":
		print("Pushed monster back")
		currentState._transitioned.emit(currentState, "Knocking")
		_enteringTimer.stop()

func _on_hiding_timer_timeout() -> void:
	currentState._transitioned.emit(currentState, "Knocking")

func _on_knocking_timer_timeout() -> void:
	currentState._transitioned.emit(currentState, "Entering")

func _on_entering_timer_timeout() -> void:
	print("You dead")
