extends RayCast2D

onready var line = $line_2d
onready var end = $animated_sprite

export var max_distance = 1000;

func _ready():
	cast_to = Vector2(0 , max_distance)

func _physics_process(delta):
	if is_colliding():
		print(1)
		var coll_point = to_local(get_collision_point())
		line.points[1] = coll_point
		end.position = coll_point
