extends Area2D

var _playerIn = false
var _gun

func _process(delta: float) -> void:
	if _playerIn and _gun._get_bullet() == 0 and Input.is_action_just_pressed("Reload"):
		_gun._add_bullet(1)

func _on_body_entered(body) -> void:
	_playerIn = true
	_gun = body.get_node("Gun")


func _on_body_exited(body) -> void:
	_playerIn = false
	_gun = null
