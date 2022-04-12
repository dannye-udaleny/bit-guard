extends Camera2D

onready var player = get_parent()

var window_size := OS.get_window_size()
var distance_to_mouse_pos: float = 0
	
	
func _physics_process(delta: float) -> void:
	position = get_local_mouse_position() / Vector2(3, 2)
