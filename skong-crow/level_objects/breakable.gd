extends CharacterBody2D

signal wall_broken

@export var speed: int = 100

var direction: int = 1
var is_facing_left: bool = false

#func _physics_process(delta: float) -> void:
	#move_and_slide()	
	#velocity.y += speed
	#velocity.x = 200 * direction
	#if is_on_wall():
		#direction *= -1
		#scale.x = -1

func _on_hurtbox_2d_damaged(damage: float) -> void:
	await get_tree().create_timer(.2).timeout
	emit_signal("wall_broken")
	queue_free()
