extends RayCast2D

onready var line = $line_2d
onready var end = $sprite

export var max_distance = 1000;

func _ready():
	cast_to = Vector2(0,max_distance)
	
func _physics_process(delta):
	if is_colliding():
		var coll_point = to_local(get_collision_point())
		line.points[1].y = coll_point.y
		end.position.y = coll_point.y
	else:
		line.points[1].y = max_distance
		end.position.y = max_distance
	
	
