extends CharacterBody2D

@onready var animations: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D

@export var speed: int = 240
@export var movement_acceleration: int = 20
@export var dash_speed: int = 1000
@export var max_dash_count: int = 1
var dash_count: int = 0

@export var gravity: int = 15
@export var base_gravity: int = 15
@export var float_speed: int = 4
@export var wall_drag_speed: int = 1

@export var ground_jump_speed: int = -speed * 2
@export var midair_jump_speed: int = -speed * 2
@export var max_midair_jumps: int = 1
var midair_jump_count: int = 0

var is_facing_left: bool = false

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
		animations.play("glide")
	
	#Falling
	if not is_on_floor() and not is_on_wall():
		gravity = base_gravity
		animations.play("air")
	elif is_on_wall():
		gravity = wall_drag_speed
		dash_count = 0
		midair_jump_count = 0
		animations.play("ground")
	elif is_on_floor():
		gravity = base_gravity
		dash_count = 0
		midair_jump_count = 0
		animations.play("ground")

	#Midair Jump
	if Input.is_action_just_pressed("jump") and not is_on_floor() \
			and midair_jump_count < max_midair_jumps:
		velocity.y = midair_jump_speed
		midair_jump_count += 1
		animations.play("glide")
	if is_on_floor():
		dash_count = 0
		midair_jump_count = 0
		animations.play("ground")
	
	#Float / Glide
	if Input.is_action_pressed("jump") and velocity.y > 0 \
			and not is_on_floor() and not is_on_wall():
		gravity = float_speed
		animations.play("glide")

	if (abs(velocity.x) - speed) > 0:
		animations.play("glide")
		
	#Attack
	if Input.is_action_pressed("ui_up") \
			and Input.is_action_just_pressed("attack"):
		animations.play("peck_up")
	elif Input.is_action_pressed("ui_down") and not is_on_floor() \
			and not is_on_wall() and Input.is_action_just_pressed("attack"):
		animations.play("scratch_down")
	elif Input.is_action_just_pressed("attack") and not is_on_floor() \
			and not is_on_wall():
		animations.play("scratch")
	elif Input.is_action_just_pressed("attack") and is_on_floor():
		animations.play("peck")
	else:
		animations.play("RESET")
		
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
	
	
