class_name PlayerJumping
extends State

#EXPORT
@export var jump_velocity: float = -300
#ONREADY
@onready var player: CharacterBody2D = $"../.."

func enter():
	player.velocity.y = jump_velocity

func update(delta: float) -> void:
	if player.velocity.y >= 0:
		self.transitioned.emit(self, "Falling")
