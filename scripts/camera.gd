extends Camera2D

onready var player = get_parent()

var window_size = OS.get_window_size()
var distance_to_mouse_pos: float = 0

func _ready():
	limit_top = 0
	limit_bottom = 750
	limit_left = 0
	limit_right = 1000
	
func _physics_process(delta: float) -> void:
	var mouse_position = get_global_mouse_position()
	if mouse_position != null:
		position = (mouse_position + player.position)/2 - player.position
		distance_to_mouse_pos = player.position.distance_to(position)
