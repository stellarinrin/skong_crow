extends CharacterBody2D

func _physics_process(delta: float) -> void:
	pass

func _on_hurtbox_2d_damaged(damage: float) -> void:
	await get_tree().create_timer(.2).timeout
	queue_free()
