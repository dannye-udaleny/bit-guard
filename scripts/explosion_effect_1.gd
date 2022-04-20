extends Particles2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	emitting = true

func _physics_process(delta):
	if emitting == false:
		queue_free()
	
