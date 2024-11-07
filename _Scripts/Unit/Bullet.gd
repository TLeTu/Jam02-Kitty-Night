extends Area2D

@export var mass: float = 0.25

var launched = false
var velocity = Vector2(0, 0)
var _gravity = 9.8


func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if launched:
		velocity += gravity_direction * _gravity * mass
		position += velocity * delta
		rotation = velocity.angle()

func launch(initial_velocity: Vector2):
	launched = true
	velocity = initial_velocity

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
		queue_free()# Replace with function body.
