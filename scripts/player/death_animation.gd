extends Sprite
class_name DeathAnimation

export var delay: float    # Время анимации смерти (s)

var last_checkpoint: Vector2
var shader_progress = 0.0

signal animation_ended


func _ready():
	$tween.interpolate_property(self, "shader_progress", 0.0, 1.0, 1.0)
	$tween.start()
	yield($tween, "tween_completed")
	emit_signal("animation_ended")
#	queue_free()	
	# как-то поставить нового игрока на сцену

func _process(delta):
	material.set_shader_param("progress", shader_progress)
