extends Node2D

const _bullet = preload("res://Nodes/bullet.tscn")

@onready var _marker: Marker2D = $Marker2D
@export var _bulletNum: int = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -0.5
	else:
		scale.y = 0.5
		
	if Input.is_action_just_pressed("Shoot") and _bulletNum > 0:
		var bullet_instance = _bullet.instantiate()
		var launch_vector
		if get_global_mouse_position().x > 0:
			launch_vector = Vector2(50, -200)
		else:
			launch_vector = Vector2(-50, -200)
		get_tree().root.add_child(bullet_instance)
		bullet_instance.global_position = _marker.global_position
		bullet_instance.rotation = rotation
		bullet_instance.launch(launch_vector)
		_bulletNum -= 1

func _add_bullet(num: int):
	_bulletNum += num

func _get_bullet():
	return _bulletNum
