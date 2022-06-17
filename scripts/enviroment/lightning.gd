extends RayCast2D

onready var line = $line_2d
onready var end = $sprite

export var max_distance = 600;

signal health_changed(amount)

func _ready():
	cast_to = Vector2(0,max_distance)
	
func _physics_process(delta):
	$end_area.position = end.position #+ Vector2(0, -75.0)
	if is_colliding():
		var coll_point = to_local(get_collision_point())
		line.points[1].y = coll_point.y
		end.position.y = coll_point.y
		if get_collider().get_parent().has_method("die"):
			var entity = get_collider().get_parent()
			if entity is Player:
				if entity._is_dashing:
					return
				emit_signal("health_changed", 0)
			entity.die()
	else:
		line.points[1].y = max_distance
		end.position.y = max_distance
	
