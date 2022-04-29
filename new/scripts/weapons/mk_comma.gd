extends Weapon

export var bullet_speed: float
export var randomness: float

func mouse_pressed() -> void:
	if $shoot_cooldown.is_stopped():
		shoot()
		$shoot_cooldown.start()


func mouse_released() -> void:
	play("idle")


func set_flipped(flipped: bool) -> void:
	flip_v = flipped
	offset.y = 3 if flipped else -3
	$tip.position.y = 1.5 if flipped else -1.5


func shoot() -> void:
	if not Input.is_action_pressed("shoot"):
		return
	play("shoot")
	var bullet: Projectile = projectile_scene.instance()
	$"/root".add_child(bullet)
	bullet.global_position = $tip.global_position
	bullet.rotation = get_parent().rotation
	bullet.launch(global_position.direction_to(get_global_mouse_position()).rotated((randf() - 0.5) * randomness), bullet_speed)
	$shoot_cooldown.start()
	
	
