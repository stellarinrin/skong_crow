extends CharacterBody2D

@export var speed: int = 240
@export var movement_acceleration: int = 20
@export var dash_speed: int = 1000
@export var max_dash_count: int = 1
var dash_count: int = 0

@export var gravity: int = 15
@export var base_gravity: int = 15
@export var float_speed: int = 4

@export var ground_jump_speed: int = -speed * 2
@export var midair_jump_speed: int = -speed * 2
@export var max_midair_jumps: int = 1
var midair_jump_count: int = 0

func _physics_process(delta: float) -> void:
	handle_input()
	move_and_slide()
	velocity.y += gravity
	
func handle_input() -> void:
	#Horizontal Movement
	var direction = Input.get_axis("ui_left","ui_right")
	if direction == 0:
		velocity.x = move_toward(velocity.x, 0, movement_acceleration)
	elif Input.is_action_just_pressed("dash") and dash_count < max_dash_count:
		velocity.x = dash_speed * direction
		dash_count = 1
	else:
		velocity.x = move_toward(velocity.x, speed * direction, movement_acceleration)
	
	#Ground Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = ground_jump_speed
	
	#Midair Jump
	if Input.is_action_just_pressed("jump") and not is_on_floor() \
			and midair_jump_count < max_midair_jumps:
		velocity.y = midair_jump_speed
		midair_jump_count += 1
	if is_on_floor() or is_on_wall():
		dash_count = 0
		midair_jump_count = 0
	
	#Float / Glide
	if Input.is_action_pressed("jump") and velocity.y >= 0:
		gravity = float_speed
	else:
		gravity = base_gravity
	
	
