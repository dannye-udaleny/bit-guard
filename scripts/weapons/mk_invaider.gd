extends Weapon

export var randomness: float


func process_shooting() -> void:
	for i in range(-2,3):
		var angle = i * PI / 24
		var bullet_1: Projectile = projectile_scene.instance()
		$"/root".add_child(bullet_1)
		bullet_1.global_position = $tip.global_position
#		bullet_1.rotation = get_parent().rotation
		bullet_1.launch((global_position.direction_to(get_global_mouse_position())).rotated(angle), bullet_speed)
	
	
func start_reload() -> void:
	play("reload")
	
	
func end_reload() -> void:
	play("idle")
