class_name PlayerFalling
extends State

#EXPORT
@export var fall_move_speed : float = 130
#PRIVATE
var _direction
#ONREADY
@onready var player: CharacterBody2D = $"../.."

func update(delta: float) -> void:
	if player.is_on_floor():
		self.transitioned.emit(self, "Idle")

func physics_update(delta: float) -> void:
	_direction = Input.get_axis("MoveLeft", "MoveRight")
	player.velocity.x = _direction * fall_move_speed
