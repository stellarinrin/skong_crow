extends Node2D

signal won
var is_dialogue_active: bool = false
var has_dialogue_played: bool = false
var dialogue_line: int = 2

func _process(delta: float) -> void:
	if not is_dialogue_active:
		return
	if Input.is_action_just_pressed("ui_text_newline"):
		match dialogue_line:
			2:
				$Dialogue/TextboxBorder/Textbox/Line1.visible = false
				$Dialogue/TextboxBorder/Textbox/Line2.visible = true
				dialogue_line = 3
			3:
				$Dialogue/TextboxBorder/Textbox/Line2.visible = false
				$Dialogue/TextboxBorder/Textbox/Line3.visible = true
				dialogue_line = 0
			0:
				$Dialogue/TextboxBorder/Textbox/Line3.visible = false
				is_dialogue_active = false
				$Dialogue.visible = false
func _on_rat_rat_killed() -> void:
	%IntroPlatform.visible = true
	%IntroPlatform.collision_layer = 1
	$climb_instructions.visible = true
	$Crow.has_climb = true


func _on_area_2d_area_entered(area: Area2D) -> void:
	emit_signal("won")
	$Dialogue.visible = true
	$Dialogue/ButtonPrompt.visible = false
	$Dialogue/TextboxBorder/Textbox/Line4.visible = true
	await get_tree().create_timer(.7).timeout
	$Dialogue/TextboxBorder/Textbox/Line5.visible = true
	await get_tree().create_timer(1).timeout
	$Dialogue.visible = false
	Global.game_controller._change_scene("res://levels/main_menu.tscn")


func _on_dialogue_trigger_area_entered(area: Area2D) -> void:
	if has_dialogue_played:
		return
	$Dialogue.visible = true
	$Dialogue/TextboxBorder/Textbox/Line1.visible = true
	is_dialogue_active = true
	has_dialogue_played = true
