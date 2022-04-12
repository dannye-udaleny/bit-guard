extends Camera2D

onready var player = get_parent()

var window_size = OS.get_window_size()
var distance_to_mouse_pos: float = 0

func _ready():
	#limit_top = 0
	#limit_bottom = 750
	#limit_left = 0
	#limit_right = 1000
	pass
	
func _physics_process(delta: float) -> void:
	position = get_local_mouse_position() / Vector2(3, 2)
#	var viewport_center = get_viewport().size / 2
#	var mouse_position = get_viewport().get_mouse_position()
#	var target = viewport_center.linear_interpolate(mouse_position, 0.25)
#	position = player.position + target - viewport_center
#	if mouse_position != null:		
#		position = (mouse_position + player.position)/2 - player.position
#		distance_to_mouse_pos = player.position.distance_to(position)
