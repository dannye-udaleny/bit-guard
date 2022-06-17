extends Weapon


func process_shooting() -> void:
	var bullet: Projectile = projectile_scene.instance()
	$"/root".add_child(bullet)
	bullet.global_position = $tip.global_position
#	bullet.rotation = get_parent().rotation
	bullet.direction = bullet.direction.rotated(bullet.rotation)
	bullet.launch(global_position.direction_to(get_global_mouse_position()), bullet_speed)


func start_reload() -> void:
	play("reload")


func end_reload() -> void:
	play("idle")
