extends RayCast2D

onready var end = $sprite
onready var line = $line

var max_distance = 100


func _ready():
	cast_to = Vector2(0,max_distance)
	
func _physics_process(delta):
	if is_colliding():
		var coll_point = to_local(get_collision_point())
		line.points[1].x  = coll_point.x
		end.position = coll_point
	else:
		cast_to = Vector2(0,max_distance)
		end.position = Vector2(0,max_distance)
