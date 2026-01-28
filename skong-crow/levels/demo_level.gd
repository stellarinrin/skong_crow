extends Node2D

signal won
func _on_rat_rat_killed() -> void:
	%IntroPlatform.visible = true
	%IntroPlatform.collision_layer = 1
	$climb_instructions.visible = true
	$Crow.has_climb = true


func _on_area_2d_area_entered(area: Area2D) -> void:
	emit_signal("won")
	await get_tree().create_timer(1).timeout
	Global.game_controller._change_scene("res://levels/main_menu.tscn")
