extends Node2D

onready var reload_bar = get_parent().get_node("reload_bar")

export(PackedScene) var bullet_scene

var state
var bullet_number:int = 30
var bullet_counter

enum states{
	idle,
	shoot,
	reload
}


func _ready() -> void:
	InputHandler.connect("mouse_pressed", self, "_shoot_bullet")
	state = states.idle
	bullet_counter = bullet_number


func _process(delta:float) -> void:
	$flash_sprite.flip_v = $sprite.flip_v
	$flash_sprite.animation = $sprite.animation
	_rotation()
	_state_machine()
	_play_animation()
#	if state == states.idle:
#		get_parent().get_node("label").set_text("idle")
#	elif state == states.shoot:
#		get_parent().get_node("label").set_text("shoot")
#	elif state == states.reload:
#		get_parent().get_node("label").set_text("reload")


func _rotation() -> void:
	$sprite.look_at(get_parent().mouse)
	$flash_sprite.look_at(get_parent().mouse)
	if get_parent().get_node("body_sprite").flip_h == true:
		$sprite.flip_v = true
		$sprite.position = Vector2(4, 0)
		$sprite.offset = Vector2(3, 5)
		$flash_sprite.position = $sprite.position
		$flash_sprite.offset = $sprite.offset
	else:
		$sprite.flip_v = false
		$sprite.position = Vector2(0, 0)
		$sprite.offset = Vector2(3, -5)
		$sprite/end.position = Vector2(19,-0.5)
		$flash_sprite.position = $sprite.position
		$flash_sprite.offset = $sprite.offset


func _shoot_bullet() -> void:
	if $sprite.animation != "shoot" and bullet_counter != 0 and state != states.reload:
		bullet_counter -= 1
		var bullet = bullet_scene.instance()
		bullet.rotation = $sprite.rotation
		bullet.direction = bullet.direction.rotated(bullet.rotation)
		bullet.global_position = $sprite/end.global_position
		get_tree().get_root().add_child(bullet)
	elif bullet_counter == 0 and state != states.reload:
		state = states.reload


func _play_animation() -> void:
	if state == states.idle: 
		$sprite.play("idle")
	if state == states.shoot and bullet_counter != 0:
		$sprite.play("shoot")
	if state == states.reload:
		$sprite.play("reload")
		reload_bar.visible = true
		reload_bar.value = $sprite.frame


func _state_machine():
	if state == states.idle:
		if Input.is_action_just_pressed("shoot")  and bullet_counter != 0:
			state = states.shoot
		elif Input.is_action_just_pressed("reload") and bullet_counter != bullet_number:
			state = states.reload
	elif state == states.shoot:
		if bullet_counter == 0:
			state = states.reload
		elif bullet_counter < bullet_number:
			if Input.is_action_just_pressed("reload"):
				state = states.reload
		


func _on_sprite_animation_finished():
	if state == states.shoot and $sprite.animation == "shoot":
		$sprite.play("idle")
		if not Input.is_action_pressed("shoot"):
			state = states.idle
		else:
			_shoot_bullet()
	if $sprite.animation == "reload":
		reload_bar.visible = false
		bullet_counter = bullet_number
		if Input.is_action_pressed("shoot"):
			state = states.shoot
			_shoot_bullet()
		else:
			state = states.idle

