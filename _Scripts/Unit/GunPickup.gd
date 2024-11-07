extends Area2D

var _playerIn = false
var _player

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Pickup") and _playerIn and _player != null:
		if _player._is_holding_item():
			print("yes")
		else:
			print("no")

func _on_body_entered(body: Node2D) -> void:
	_playerIn = true
	_player = body

func _on_body_exited(body: Node2D) -> void:
	_playerIn = false
	_player = null
