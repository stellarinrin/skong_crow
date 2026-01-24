extends CharacterBody2D

@export var speed: int = 240
@export var movement_acceleration: int = 20
@export var jump_speed: int = -speed * 2
@export var gravity: int = 15

func _physics_process(delta: float) -> void:
	handle_input()
	move_and_slide()
	velocity.y += gravity
	
func handle_input() -> void:
	if Input.is_action_just_pressed("jump"):
		velocity.y = jump_speed
	
	var direction = Input.get_axis("ui_left","ui_right")
	if direction == 0:
		velocity.x = move_toward(velocity.x, 0, movement_acceleration)
	else:
		velocity.x = move_toward(velocity.x, speed * direction, movement_acceleration)
