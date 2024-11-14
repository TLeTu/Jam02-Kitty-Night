class_name Player
extends CharacterBody2D

#EXPORT
@export var run_speed : float = 130
@export var max_jump_velocity : float  = -300
@export var raycast_range: float = 20
#PUBLIC

#PRIVATE
var _is_holding_item: bool = false
var _item: Node2D
var _direction
#ONREADY
@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: StateMachine = $StateMachine
@onready var raycast: RayCast2D = $RayCast2D
@onready var item_holder: Area2D = $ItemHolder

func _process(delta: float) -> void:
	_direction = Input.get_axis("MoveLeft", "MoveRight")
	
	animate()
	flip_model()

	if Input.is_action_just_pressed("Jump") and is_on_floor():
		state_machine.current_state().transitioned.emit(state_machine.current_state(), "Jumping")

func _physics_process(delta: float) -> void:
	move_and_slide()
	
	if not is_on_floor():
		velocity += get_gravity() * delta

func flip_model() -> void:
	if _direction > 0:
		animation.flip_h = false
		raycast.target_position.x = raycast_range
		item_holder.flip_item(false)
	elif _direction < 0:
		animation.flip_h = true
		raycast.target_position.x = -raycast_range
		item_holder.flip_item(true)

func animate() -> void:
	match state_machine.current_state().name:
		"Idle": 
			animation.play("Idle")
		"Moving":
			animation.play("Moving")
		"Jumping":
			animation.play("Jumping")
		"Falling":
			animation.play("Falling")
