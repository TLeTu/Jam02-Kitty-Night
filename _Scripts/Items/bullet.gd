extends Area2D

@export var mass: float = 0.25

var _launched = false
var _velocity = Vector2(0, 0)
var _gravity = 9.8

func _physics_process(delta: float) -> void:
	if _launched:
		_velocity += gravity_direction * _gravity * mass
		position += _velocity * delta
		rotation = _velocity.angle()

func launch(initial_velocity: Vector2):
	_launched = true
	_velocity = initial_velocity

func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()
