extends AnimatedSprite

export(PackedScene) var bullet_scene


func _ready() -> void:
	InputHandler.connect("left_button_clicked", self, "_shoot_bullet")


func _process(delta) -> void:
	_rotation()
	$flash_sprite.flip_v = flip_v
	$flash_sprite.animation = animation
	$flash_sprite.offset = offset


func _rotation() -> void:
	look_at(get_parent().mouse)
	if get_parent().get_node("body_sprite").flip_h == true:
		self.flip_v = true
		offset = Vector2(3, 5)
		position = Vector2(3, -17)
		$flash_sprite.position = Vector2(1, 1)
	else:
		self.flip_v = false
		$flash_sprite.position = Vector2(-1, -1)
		offset = Vector2(3, -5)
		position = Vector2(-1, -17)


func _shoot_bullet() -> void:
	var bullet = bullet_scene.instant()
	bullet.rotation = rotation
	bullet.direction = $direction/direction_shape
