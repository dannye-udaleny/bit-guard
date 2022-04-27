extends Weapon

export var bullet_speed: float

func mouse_pressed() -> void:
	shoot()
	$shoot_cooldown.start()


func mouse_released() -> void:
	$shoot_cooldown.stop()
	play("idle")


func set_flipped(flipped: bool) -> void:
	flip_v = flipped
	offset.y = 3 if flipped else -3
	$tip.position.y = 1.5 if flipped else -1.5


func shoot() -> void:
	play("shoot")
	var bullet: Projectile = projectile_scene.instance()
	$"/root".add_child(bullet)
	bullet.global_position = $tip.global_position
	bullet.rotation = get_parent().rotation
	bullet.direction = bullet.direction.rotated(bullet.rotation)
	bullet.launch(global_position.direction_to(get_global_mouse_position()), bullet_speed)



#func _on_mk_bit_animation_finished():
#	if animation == "shoot":
#		play("idle")
