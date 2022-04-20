extends Particles2D

func _ready():
	emitting = true

func _physics_process(delta):
	if emitting == false:
		queue_free()

