extends TextureRect

onready var scroll_speed = -3.1

func _ready() -> void:
#	if get_parent().turn:
	self.material.set_shader_param("scroll_speed", scroll_speed)
#
#
#func _process(delta):
#	if get_parent().turn:
#		self.material.set_shader_param("scroll_speed", scroll_speed)
#	else:
#		self.material.set_shader_param("scroll_speed", 0)
