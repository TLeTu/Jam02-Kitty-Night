extends Area2D

var is_holding_item = false
var _item : ItemBase = null
@onready var player: CharacterBody2D = $"."

func _process(delta: float) -> void:
	if is_holding_item:
		rotate_item()
		_item.update(delta)

func set_hold_item(item: Node) -> void:
	if not is_holding_item:
		_item = item
	else: return

func rotate_item() -> void:
	_item.look_at(get_global_mouse_position())
	_item.rotation_degrees = wrap(_item.rotation_degrees, 0, 360)
	if _item.rotation_degrees > 90 and _item.rotation_degrees < 270:
			_item.scale.y = -0.5
	else:
			_item.scale.y = 0.5
