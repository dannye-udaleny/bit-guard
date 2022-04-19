extends Node


var input_direction := Vector2()


signal mouse_pressed 
signal dash(press)
signal exit
signal change_weapon(type)
signal change_theme

func _physics_process(delta: float) -> void:
	input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")).normalized()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		emit_signal("mouse_pressed")
	if event.is_action_pressed("dash"):
		emit_signal("dash", true)
	if event.is_action_pressed("esc"):
		emit_signal("exit")
	if event.is_action_pressed("button_1"):
		emit_signal("change_wepon", 1)
	if event.is_action_pressed("button_2"):
		emit_signal("change_wepon", 2)
	if event.is_action_pressed("button_3"):
		emit_signal("change_wepon", 3)
	if event.is_action_pressed("button_4"):
		emit_signal("change_wepon", 4)
	if event.is_action_pressed("change"):
		emit_signal("change_theme")
