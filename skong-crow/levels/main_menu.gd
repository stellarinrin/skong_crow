extends Control

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		Global.game_controller._change_scene("res://levels/demo_level.tscn")
