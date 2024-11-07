extends Node2D

const _bullet = preload("res://Nodes/bullet.tscn")

@onready var _marker: Marker2D = $Marker2D
@onready var _stateMachine: Node = $StateMachine
@onready var _collision: CollisionShape2D = $CollisionShape2D
@export var _bulletNum: int = 1
@export var _bulletSpeed: float = 100
@export var _player: CharacterBody2D
@export var _objectHolder: Node

var _currentState: State
var _playerIn = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_currentState = _stateMachine._get_current_state()
	if _currentState.get_name() == "Grounded" and _playerIn:
		if Input.is_action_just_pressed("Pickup"):
			_pick_up()
	if _currentState.get_name() == "PickedUp":
		look_at(get_global_mouse_position())
		rotation_degrees = wrap(rotation_degrees, 0, 360)
		if rotation_degrees > 90 and rotation_degrees < 270:
			scale.y = -0.5
		else:
			scale.y = 0.5
		if Input.is_action_just_pressed("Drop"):
			_drop()
		if Input.is_action_just_pressed("Shoot") and _bulletNum > 0:
			var bullet_instance = _bullet.instantiate()
			var launch_vector = _calculate_launch_velocity()
			get_tree().root.add_child(bullet_instance)
			bullet_instance.global_position = _marker.global_position
			bullet_instance.rotation = rotation
			bullet_instance.launch(launch_vector)
			_bulletNum -= 1

func _calculate_launch_velocity() -> Vector2:
	# Calculate direction vector from marker to mouse
	var direction = (get_global_mouse_position() - _marker.global_position).normalized()
	return direction * _bulletSpeed

func _pick_up():
	_currentState._transitioned.emit(_currentState, "PickedUp")
	_collision.disabled = true
	get_parent().remove_child(self)
	_player.add_child(self)
	position = Vector2(4, 4)
	_player._isHoldingGun = true

func _drop():
	_currentState._transitioned.emit(_currentState, "Grounded")
	_collision.disabled = false
	get_parent().remove_child(self)
	_objectHolder.add_child(self)
	position = _player.position
	_player._isHoldingGun = false

func _add_bullet(num: int):
	_bulletNum += num

func _get_bullet():
	return _bulletNum

func _on_body_entered(body: Node2D) -> void:
	_playerIn = true

func _on_body_exited(body: Node2D) -> void:
	_playerIn = false
