class_name PlayerMoving
extends State

#EXPORT
@export var run_speed : float = 130
#PRIVATE
var _direction
#ONREADY
@onready var player : CharacterBody2D = $"../.."

func physics_update(delta: float) -> void:
	_direction = Input.get_axis("MoveLeft", "MoveRight")
	player.velocity.x = _direction * run_speed
	
	if not _direction:
		self.transitioned.emit(self, "Idle")
