extends CharacterBody2D

@onready var movement_animations: AnimationPlayer = $MovementAnimations
@onready var attack_animations: AnimationPlayer = $AttackAnimations
@onready var sprite: Sprite2D = $Sprite2D

@export var speed: int = 240
@export var movement_acceleration: int = 20
@export var dash_speed: int = 1000
@export var max_dash_count: int = 1
var dash_count: int = 0

@export var gravity: int = 15
@export var base_gravity: int = 15
@export var float_speed: int = 4
@export var climb_speed: int = 120

@export var ground_jump_speed: int = -speed * 2
@export var midair_jump_speed: int = -speed * 2
@export var max_midair_jumps: int = 1
var midair_jump_count: int = 0

var is_facing_left: bool = false
var is_clinging: bool = false
var attack_frames: int = 4
var attack_frame_count: int = 0
var is_attacking: bool = false

var has_climb: bool = false

func _physics_process(delta: float) -> void:
	handle_input()
	move_and_slide()
	velocity.y += gravity
	
func handle_input() -> void:
	if is_attacking and attack_frame_count < attack_frames:
		attack_frame_count += 1
	else:
		is_attacking = false
		attack_frame_count = 0
	
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
		movement_animations.play("glide")
	
	#Falling
	if not is_on_floor() and not is_on_wall():
		gravity = base_gravity
		is_clinging = false
		movement_animations.play("air")
	elif is_on_wall() and direction != 0 and has_climb:
		velocity.y = 0
		is_clinging = true
		dash_count = 0
		midair_jump_count = 0
		movement_animations.play("ground")
		if Input.is_action_pressed("ui_up"):
			velocity.y = - climb_speed
	elif is_on_wall() and direction == 0:
		is_clinging = false
	elif is_on_floor():
		gravity = base_gravity
		is_clinging = false
		dash_count = 0
		midair_jump_count = 0
		movement_animations.play("ground")

	#Midair Jump
	if Input.is_action_just_pressed("jump") and not is_on_floor() \
			and midair_jump_count < max_midair_jumps \
			and not is_clinging:
		velocity.y = midair_jump_speed
		midair_jump_count += 1
		movement_animations.play("glide")
	if is_on_floor():
		dash_count = 0
		midair_jump_count = 0
		movement_animations.play("ground")
	
	#Float / Glide
	if Input.is_action_pressed("jump") and velocity.y > 0 \
			and not is_on_floor() and not is_on_wall():
		gravity = float_speed
		movement_animations.play("glide")

	if (abs(velocity.x) - speed) > 0:
		movement_animations.play("glide")
		
	#Attack
	if is_attacking:
		pass
	else:
		if Input.is_action_pressed("ui_up") \
				and Input.is_action_just_pressed("attack"):
			is_attacking = true
			attack_animations.play("peck_up")
		elif Input.is_action_pressed("ui_down") and not is_on_floor() \
				and not is_on_wall() and Input.is_action_just_pressed("attack"):
			is_attacking = true
			attack_animations.play("scratch_down")
		elif Input.is_action_just_pressed("attack") and not is_on_floor() \
				and not is_on_wall():
			is_attacking = true
			attack_animations.play("scratch")
		elif Input.is_action_just_pressed("attack") and is_on_floor():
			is_attacking = true
			attack_animations.play("peck")
		else:
			attack_animations.play("RESET")
		
	if direction > 0:
		if not is_facing_left:
			return
		scale.x = -1
		#sprite.flip_h = false
		is_facing_left = false
	elif direction < 0:
		if is_facing_left:
			return
		scale.x = -1
		#sprite.flip_h = true
		is_facing_left = true
		
	
