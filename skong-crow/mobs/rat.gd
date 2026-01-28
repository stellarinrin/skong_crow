extends CharacterBody2D

signal rat_killed

@export var speed: int = 100
@export var bump: AudioStream
@export var death: AudioStream

var direction: int = 1
var is_facing_left: bool = false

func _physics_process(delta: float) -> void:
	move_and_slide()	
	velocity.y += speed
	velocity.x = 200 * direction
	if is_on_wall():
		direction *= -1
		scale.x = -1
		$AudioStreamPlayer2D.stream = bump
		$AudioStreamPlayer2D.play()

func _on_hurtbox_2d_damaged(damage: float) -> void:
	$AudioStreamPlayer2D.stream = death
	direction = 0
	$AudioStreamPlayer2D.play()
	await get_tree().create_timer(.5).timeout
	emit_signal("rat_killed")
	queue_free()
