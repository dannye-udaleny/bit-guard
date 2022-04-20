extends TextureRect

onready var scroll_speed = -3

func _ready() -> void:
	self.material.set_shader_param("scroll_speed", scroll_speed)

