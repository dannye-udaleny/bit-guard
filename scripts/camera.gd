extends Camera2D
onready var player = $"../player"

func _ready():
	pass
	
func _physics_process(delta: float) -> void:
	var mouse_position = get_global_mouse_position()

	



