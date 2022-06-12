extends Particles2D
class_name Explosion

func _ready():
	emitting = true

func _physics_process(_delta):
	if emitting == false:
		queue_free()

