extends Gun

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_currentState = _stateMachine._get_current_state()
	if _currentState.get_name() == "Grounded":
		if position.y < 75:
			position += _gravity * delta * gravity_direction
		if Input.is_action_just_pressed("Pickup") and _playerIn:
			_pick_up()
	if _currentState.get_name() == "PickedUp":
		look_at(get_global_mouse_position())
		rotation_degrees = wrap(rotation_degrees, 0, 360)
		if rotation_degrees > 90 and rotation_degrees < 270:
			scale.y = -0.5
		else:
			scale.y = 0.5
		if Input.is_action_just_pressed("Drop"):
			_drop()

func _pick_up():
	_currentState._transitioned.emit(_currentState, "PickedUp")
	_collision.disabled = true
	get_parent().remove_child(self)
	_player.add_child(self)
	position = Vector2(4, 4)
	_player._isHoldingObject = true
	_player._object = self

func _drop():
	_currentState._transitioned.emit(_currentState, "Grounded")
	_collision.disabled = false
	get_parent().remove_child(self)
	_objectHolder.add_child(self)
	position = _player.position
	_player._isHoldingObject = false
	_player._object = null

func _on_flashlight_body_entered(body: Node2D) -> void:
	_playerIn = true

func _on_flashlight_body_exited(body: Node2D) -> void:
	_playerIn = false
