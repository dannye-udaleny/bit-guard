extends TextureRect

onready var scroll_speed = -1.53

func _ready():
	self.material.set_shader_param("scroll_speed", scroll_speed)	
