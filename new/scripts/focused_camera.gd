extends Camera2D

export var target_path: NodePath
export (float, 0, 1) var offset_power: float
export (float, 0, 1) var weight: float

onready var target := get_node(target_path) as Node2D


func _process(_delta: float) -> void:
	var target_pos := target.global_position
	if offset_power != 0:
		target_pos += (get_global_mouse_position() - global_position) * offset_power
	global_position = lerp(global_position, target_pos, weight)
