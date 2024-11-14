class_name Gun
extends ItemBase


@export var bullet_num: int = 1
@export var bullet_speed: float = 100

const _bullet = preload("res://Scenes/Items/bullet.tscn")
var _bullet_current_num

@onready var _marker: Marker2D = $Marker2D
@onready var _collision: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	_bullet_current_num = bullet_num

func _process(delta: float) -> void:
	super._process(delta)
	if Input.is_action_just_pressed("Shoot") and _bullet_current_num > 0 and picked_up:
		var bullet_instance = _bullet.instantiate()
		var launch_vector = calculate_launch_velocity()
		get_tree().root.add_child(bullet_instance)
		bullet_instance.global_position = _marker.global_position
		bullet_instance.rotation = rotation
		bullet_instance.launch(launch_vector)
		_bullet_current_num -= 1

func calculate_launch_velocity() -> Vector2:
	var direction = (get_global_mouse_position() - _marker.global_position).normalized()
	return direction * bullet_speed

func add_bullet(num: int) -> void:
	if _bullet_current_num < bullet_num:
		_bullet_current_num += num

func activate() -> void:
	_collision.disabled = true
	picked_up = true

func disable() -> void:
	_collision.disabled = false
	picked_up = false
