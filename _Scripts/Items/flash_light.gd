class_name FlashLight
extends ItemBase

@onready var _light: Light2D = $PointLight2D
@onready var _collision: CollisionShape2D = $CollisionShape2D


func activate() -> void:
	picked_up = true
	_collision.disabled = true
	_light.enabled = true

func disable() -> void:
	picked_up = false
	_collision.disabled = false
	_light.enabled = false
