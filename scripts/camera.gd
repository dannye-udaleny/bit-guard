extends Camera2D

func _physics_process(delta: float) -> void:
	position = get_local_mouse_position() / Vector2(3, 2)
