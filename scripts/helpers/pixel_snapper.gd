extends Node2D

onready var parent = get_parent() as Node2D


func _process(delta: float) -> void:
	global_position = parent.global_position.round()
