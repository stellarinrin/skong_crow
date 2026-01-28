extends Node2D


func _on_rat_rat_killed() -> void:
	$IntroPlatform.visible = true
	$IntroPlatform.collision_layer = 1
	$climb_instructions.visible = true
	$Crow.has_climb = true


func _on_area_2d_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
