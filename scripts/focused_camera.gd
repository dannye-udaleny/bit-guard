extends Camera2D

export (float, 0, 1) var offset_power: float
export (float, 0, 1) var weight: float

var target: Node2D = null


func _process(_delta: float) -> void:
	if target == null or not is_instance_valid(target):
		return
	var target_pos := target.global_position
	if offset_power != 0:
		target_pos += (get_global_mouse_position() - global_position) * offset_power
	global_position = lerp(global_position, target_pos, weight)
