extends Area2D

var _playerIn = false
var _gun

func _process(delta: float) -> void:
	if _playerIn and Input.is_action_just_pressed("Reload") and _gun != null:
		if _gun._get_bullet() == 0:
			_gun._add_bullet(1)

func _on_body_entered(body) -> void:
	_playerIn = true
	if body._isHoldingObject and body._object.get_name() == "Gun":
		_gun = body.get_node("Gun")


func _on_body_exited(body) -> void:
	_playerIn = false
	if _gun != null:
		_gun = null
