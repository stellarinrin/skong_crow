class_name Hitbox2D
extends Area2D

signal hit_landed(damage: float)

@export var hitbox_data : HitboxData
var hurtbox : Area2D
var is_timeout : bool = false
var total_damage : float

func _process(_delta: float) -> void:
	if has_overlapping_areas() and is_timeout:
		hit(hurtbox)
		is_timeout = false

## Send the damage to the hurtbox when called and call the hurt() function.
func hit(hurt_area: Hurtbox2D) -> void:
	total_damage = hitbox_data.base_damage * hitbox_data.damage_multiplier \
			+ hitbox_data.damage_modifier	
			
	## Signals that the hit connected and the damage dealt with a minimum of 0.
	hit_landed.emit(max(0, total_damage - hurt_area.total_defence))

	## Call hurtbox's hurt function.
	hurt_area.hurt(self)

## Call hit() when another area passes into the hitbox
func _on_area_entered(area2D: Area2D) -> void:
	hurtbox = area2D
	hit(area2D)

func _on_timer_timeout() -> void:
	is_timeout = true # Replace with function body.
