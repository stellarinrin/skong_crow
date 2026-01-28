extends AudioStreamPlayer
@export var flap: AudioStream
@export var landed: AudioStream
@export var glide: AudioStream
@export var dash: AudioStream
@export var peck: AudioStream
@export var claw: AudioStream
@export var jump: AudioStream


func _on_crow_claw() -> void:
	stream = claw
	play()
	
func _on_crow_dash() -> void:
	stream = dash
	play()

func _on_crow_flap() -> void:
	stream = flap
	play()

func _on_crow_glide() -> void:
	stream = glide
	play()

func _on_crow_landed() -> void:
	stream = landed
	play()

func _on_crow_peck() -> void:
	stream = peck
	play()

func _on_crow_jump() -> void:
	stream = jump
	play()
