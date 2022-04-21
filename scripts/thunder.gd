extends RayCast2D
onready var line = $line
onready var end = $sprite

var max_distance : float = 1000
export var shift: float = 10



func _ready():
	cast_to = Vector2(max_distance,0)

func _physics_process(delta):
	if is_colliding():
		print(1)
		var coll_point = to_local(get_collision_point())
		line.points[1] = coll_point
		end.position = coll_point
	else:
		print(2)

	


