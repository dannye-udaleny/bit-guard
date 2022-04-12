extends Node


var i = 0
var input_direction := Vector2()


signal mouse_pressed 

func _physics_process(delta: float) -> void:
	input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")).normalized()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		emit_signal("mouse_pressed")
		i += 1
		print(i)
		
