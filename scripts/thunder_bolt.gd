extends RayCast2D

onready var end = $sprite
onready var line = $line
onready var colision_body

var max_distance := 100


func _ready():
	cast_to = Vector2(0,max_distance)
	$area.position = Vector2(0,max_distance)


func _physics_process(delta):
	if is_colliding():
		var coll_point = to_local(get_collision_point())
		line.points[1].y  = coll_point.y
		end.position = coll_point
		$area.position = end.position
	else:
		cast_to = Vector2(0,max_distance)
		end.position = Vector2(0,max_distance)
		line.points[1].y  = max_distance
		$area.position = Vector2(0,max_distance)


func _on_area_area_entered(area):
	if area.is_in_group("hitbox"):
		colision_body = area.get_parent()
		colision_body.current_health -= 101
		$timer.start()
	elif area.is_in_group("stand_coil"):
		$sprite.visible = false


func _on_area_area_exited(area):
	if area.get_parent() == colision_body:
		colision_body = null
	elif area.is_in_group("stand_coil"):
		$sprite.visible = true


func _on_timer_timeout():
	if colision_body != null:
		colision_body.current_health -= 50
		$timer.start()
