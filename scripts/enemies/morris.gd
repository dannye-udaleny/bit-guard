extends Enemy
class_name Morris


func _ready():
	$body_sprite.play("idle")


func _physics_process(delta):
	velocity = lerp(velocity, \
		global_position.direction_to(target_body.global_position) * walk_speed \
		if is_walking and is_instance_valid(target_body) else Vector2.ZERO, 0.2)
	if target_body != null and is_instance_valid(target_body):
		$body_sprite.flip_h = global_position.x < target_body.global_position.x
	move_and_slide(velocity)


func start_moving(target: Node2D):
	if not target is Player:
		return
	target_body = target
	$body_sprite.play("run")
	is_walking = true


func stop_moving(target: Node2D):
	if not target is Player:
		return
	$body_sprite.play("idle")
	target_body = null
	is_walking = false
	velocity = Vector2.ZERO


func attack():
	pass
