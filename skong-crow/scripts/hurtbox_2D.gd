class_name Hurtbox2D
extends Area2D

signal damaged(damage: float)

@export var hurtbox_data : HurtboxData
var total_defence : float

## Signals that damage was taken and how much was taken with a minimum of 0.
func hurt(hit_area: Hitbox2D) -> void:
	total_defence = hurtbox_data.base_defence * hurtbox_data.defence_multiplier \
			+ hurtbox_data.defence_modifier
	damaged.emit(max(0, hit_area.total_damage - total_defence))
