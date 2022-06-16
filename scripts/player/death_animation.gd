extends AnimatedSprite
class_name DeathAnimation

export var delay: float    # Время анимации смерти (s)

var last_checkpoint: Vector2

signal animation_ended


func _ready():
	$timer.start(delay)
	yield($timer, "timeout")
	emit_signal("animation_ended")
	# как-то поставить нового игрока на сцену
