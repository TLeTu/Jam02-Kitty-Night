class_name ItemBase
extends Area2D

var picked_up

@export var global_y: float = 76
@export var _gravity: float = 98

func activate() -> void:
	pass

func disable() -> void:
	pass

func _process(delta: float) -> void:
	if not picked_up and global_position.y < global_y:
		global_position.y += _gravity * delta
