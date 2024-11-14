class_name PlayerIdle
extends State

#EXPORT
@onready var player : CharacterBody2D = $"../.."
#PRIVATE
var _direction

func enter() -> void:
	player.velocity.x = 0

func update(delta: float) -> void:
	_direction = Input.get_axis("MoveLeft", "MoveRight")
	
	if _direction and player.is_on_floor():
		self.transitioned.emit(self, "Moving")
