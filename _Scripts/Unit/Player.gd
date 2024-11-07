extends CharacterBody2D

@export var _animation : AnimatedSprite2D
@export var _runSpeed : float = 130
@export var _maxJumpVelocity : float  = -300
@export var _gun: Node2D
@export var _flashLight: Node2D
var _isHoldingObject = false
var _object: Node2D

func _ready() -> void:
	if not _animation:
		get_node("AnimatedSprite2D")

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	Move(delta)
	Jump()
	HandleGravity(delta)
	move_and_slide()

func Move(delta: float):
	var direction := Input.get_axis("MoveLeft", "MoveRight")
	FlipModel(direction)
	if direction:
		_animation.play("Moving")
		velocity.x = direction * _runSpeed
	else:
		_animation.play("Idle")
		velocity.x = 0

func FlipModel(direction):
	if direction > 0:
		_animation.flip_h = false
		if _isHoldingObject:
			_object.position.x = 4
	elif direction < 0:
		_animation.flip_h = true
		if _isHoldingObject:
			_object.position.x = -4

func Jump():
	if Input.is_action_pressed("Jump") and is_on_floor():
		_animation.play("Jumping")
		velocity.y = _maxJumpVelocity

func HandleGravity(delta: float):
	if not is_on_floor():
		_animation.play("Falling")
		velocity += get_gravity() * delta
