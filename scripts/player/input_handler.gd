# Этот скрипт цепится ТОЛЬКО на ноду input_handler внутри игрока
# Это НЕ синглтон
extends Node2D
class_name InputHandler

signal dashed
signal mouse_came_left
signal mouse_came_right
signal mouse_pressed
signal mouse_released
signal weapon_changed(index)
signal reload

onready var viewport := get_viewport()
onready var is_mouse_on_left := get_mouse_position().x < get_viewport_rect().size.x / 2.0


func _process(_delta: float) -> void:
	var position = get_mouse_position()
	if position.x < get_viewport_rect().size.x / 2.0:
		if not is_mouse_on_left:
			is_mouse_on_left = true
			emit_signal("mouse_came_left")
	elif is_mouse_on_left:
		is_mouse_on_left = false
		emit_signal("mouse_came_right")


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		emit_signal("mouse_pressed")
	if event.is_action_released("shoot"):
		emit_signal("mouse_released")
	if event.is_action_pressed("dash"):
		emit_signal("dashed")
	if event.is_action_pressed("+"):
		emit_signal("weapon_changed", -1)
	if event.is_action_pressed("-"):
		emit_signal("weapon_changed", -2)
	if event.is_action_pressed("reload"):
		emit_signal("reload")
	for i in range(1, 10):
		if (event.is_action_pressed("button_" + str(i))):
			emit_signal("weapon_changed", i - 1)


func get_move_direction() -> Vector2:
	# Вместо тысячи Input.is_action_pressed и input_direction
	var input = Input.get_vector("left", "right", "up", "down")
	return input.normalized()


func get_mouse_position() -> Vector2:
	return viewport.get_mouse_position()
