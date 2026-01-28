class_name GameController extends Node

@export var starting_scene : String
var current_scene : Node
func _ready() -> void:
	Global.game_controller = self
	current_scene = load(starting_scene).instantiate()
	add_child(current_scene)

func _change_scene(new_scene: String) -> void:
	if not new_scene:
		return
	current_scene.queue_free()
	var new = load(new_scene).instantiate()
	add_child(new)
	current_scene = new
	
func _on_application_quit() -> void:
	get_tree().quit(0)
