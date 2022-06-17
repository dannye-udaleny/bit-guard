extends Weapon

export var randomness: float


func process_shooting() -> void:
	var bullet: Projectile = projectile_scene.instance()
	$"/root".add_child(bullet)
	bullet.global_position = $tip.global_position
#	bullet.rotation = get_parent().rotation
	bullet.launch(global_position.direction_to(get_global_mouse_position()).rotated((randf() - 0.5) * randomness), bullet_speed)
	
	
func start_reload() -> void:
	play("reload")
	
	
func end_reload() -> void:
	play("idle")
