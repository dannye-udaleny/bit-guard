extends AnimatedSprite

export(PackedScene) var bullet_scene

var state
var bullet_number:int = 30

enum states{
	idle,
	shoot,
	reload
}


func _ready() -> void:
	InputHandler.connect("left_button_clicked", self, "_shoot_bullet")
	state = states.idle


func _process(delta) -> void:
	_rotation()
	_state_machine()
	$flash_sprite.flip_v = flip_v
	$flash_sprite.animation = animation
	$flash_sprite.offset = offset
	_play_animation()


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
	if state == states.shoot:
		var bullet = bullet_scene.instant()
		bullet.rotation = rotation
		bullet.direction = $end.position - $begin.position
		bullet.global_position = $end.global_position
		get_tree().get_root().add_child(bullet)


func _play_animation() -> void:
	match state:
		states.idle: 
			play('idle')
		states.shoot:
			play('shoot')
		states.reload:
			play('reload')



func _state_machine():
	if state == states.idle:
		if Input.is_action_just_pressed("shoot"):
			state = states.shoot
		elif Input.is_action_just_pressed("reload"):
			state = states.reload
