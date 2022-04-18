extends Node2D

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
	$flash_sprite.flip_v = $sprite.flip_v
	$flash_sprite.animation = $sprite.animation
	$flash_sprite.offset = $sprite.offset
	_rotation()
	_state_machine()
	_play_animation()


func _rotation() -> void:
	look_at(get_parent().mouse)
	if get_parent().get_node("body_sprite").flip_h == true:
		$sprite.flip_v = true
		$sprite.offset = Vector2(3, 5)
		$sprite.position = Vector2(3, -17)
		$flash_sprite.position = Vector2(1, 1)
	else:
		$sprite.flip_v = false
		$flash_sprite.position = Vector2(-1, -1)
		$sprite.offset = Vector2(3, -5)
		$sprite.position = Vector2(-1, -17)


func _shoot_bullet() -> void:
	if state == states.shoot:
		var bullet = bullet_scene.instant()
		bullet.rotation = rotation
		bullet.direction = $end.position - $begin.position
		bullet.global_position = $end.global_position
		get_tree().get_root().add_child(bullet)


func _play_animation() -> void:
	if state == states.idle: 
		$sprite.play("idle")
	if state == states.shoot:
		$sprite.play("shoot")
	if state == states.reload:
		$sprite.play("reload")


func _state_machine():
	if state == states.idle:
		get_parent().get_node("label").set_text("idle")
		if Input.is_action_just_pressed("shoot"):
			state = states.shoot
			get_parent().get_node("label").set_text("shoot")
		elif Input.is_action_just_pressed("reload"):
			state = states.reload


func _on_sprite_animation_finished():
	if $sprite.animation == "shoot":
		state = states.idle
