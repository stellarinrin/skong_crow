extends CharacterBody2D

@export var speed: int = 240
@export var movement_acceleration: int = 20
@export var ground_jump_speed: int = -speed * 2
@export var midair_jump_speed: int = -speed * 2
@export var max_midair_jumps: int = 1
@export var midair_jump_count: int = 0
@export var gravity: int = 15

func _physics_process(delta: float) -> void:
	handle_input()
	move_and_slide()
	velocity.y += gravity
	
func handle_input() -> void:
	#Horizontal Movement
	var direction = Input.get_axis("ui_left","ui_right")
	if direction == 0:
		velocity.x = move_toward(velocity.x, 0, movement_acceleration)
	else:
		velocity.x = move_toward(velocity.x, speed * direction, movement_acceleration)
	
	#Ground Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		midair_jump_count = 0
		velocity.y = ground_jump_speed
	
	#Midair Jump
	if Input.is_action_just_pressed("jump") and not is_on_floor() \
			and midair_jump_count < max_midair_jumps:
		velocity.y = midair_jump_speed
		midair_jump_count += 1
	
	
