class_name ItemBase
extends Area2D

var picked_up

var _gravity = 98

func activate() -> void:
	pass

func disable() -> void:
	pass

func _process(delta: float) -> void:
	if not picked_up and position.y < 76:
		position.y += _gravity * delta
