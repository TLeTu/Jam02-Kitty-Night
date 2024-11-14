extends Area2D

@export var scale_y: float = 0.75
@export var hold_position: Vector2 = Vector2(4,4)

var is_holding_item = false

var _item = null

@onready var player: CharacterBody2D = $".."
@onready var raycast: RayCast2D = $"../RayCast2D"
@onready var object_holder: Node = $"../../ObjectHolder"

func _process(delta: float) -> void:
	if is_holding_item and _item != null:
		rotate_item()
		if Input.is_action_just_pressed("Drop"):
			remove_hold_item()
	raycast.force_raycast_update()
	if not is_holding_item and _item == null and raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider is FlashLight or collider is Gun:
			if Input.is_action_just_pressed("Pickup"):
				set_hold_item(collider)
	if is_holding_item and _item is Gun and raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider is Magazine:
			if Input.is_action_just_pressed("Reload"):
				_item.add_bullet(1)

func set_hold_item(item) -> void:
	_item = item
	_item.activate()
	_item.get_parent().remove_child(_item)
	player.add_child(_item)
	_item.position = Vector2(4, 4)
	is_holding_item = true

func remove_hold_item() -> void:
	_item.disable()
	_item.get_parent().remove_child(_item)
	object_holder.add_child(_item)
	_item.global_position = player.global_position
	_item.rotation_degrees = 0
	_item.scale.y = scale_y
	_item = null
	is_holding_item = false

func rotate_item() -> void:
	if is_holding_item and _item != null:
		_item.look_at(get_global_mouse_position())
		_item.rotation_degrees = wrap(_item.rotation_degrees, 0, 360)
		if _item.rotation_degrees > 90 and _item.rotation_degrees < 270:
			_item.scale.y = -scale_y
		else:
			_item.scale.y = scale_y

func flip_item(flip: bool) -> void:
	if is_holding_item and _item != null:
		if flip:
			_item.position = Vector2(-hold_position.x, hold_position.y)
		else: _item.position = Vector2(hold_position.x, hold_position.y)
