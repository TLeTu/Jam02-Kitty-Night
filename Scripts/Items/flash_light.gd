extends ItemBase


@export var player: CharacterBody2D
@export var object_holder: Node

@onready var _light: Light2D = $PointLight2D
@onready var _collision: CollisionShape2D = $CollisionShape2D

func activate():
	_collision.disabled = true
	get_parent().remove_child(self)
	player.add_child(self)
	position = Vector2(4, 4)
	_light.enabled = true
	player._isHoldingObject = true
	player._object = self

func disable():
	_collision.disabled = false
	get_parent().remove_child(self)
	object_holder.add_child(self)
	position = player.position
	_light.enabled = false
	player._isHoldingObject = false
	player._object = null
