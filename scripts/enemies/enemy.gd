extends KinematicBody2D
class_name Enemy

export var health: int               # Здоровье (hp)
export var contact_damage: int       # Урон игроку при соприкосновении с врагом (hp)
export var walk_speed: int           # Скорость врага (px/s)
export var knockback: float          # На сколько враг отталкивается при уроне (px)

var velocity := Vector2()
var target_body: Node2D = null
var shader_progress = 0.0
var is_walking := false


# Функции для переопределения:
# - start_moving: начать идти в сторону цели (игрока)
# - stop_moving: прекратить идти
# - attack: атаковать цель (игрока)
# в start_moving надо будет задать target_body, в stop_moving сделать его null
# также надо задать спрайты и формы тела и хитбокса

func _process(delta):
	$body_sprite.material.set_shader_param("progress", shader_progress)


func start_moving(target: Node2D):
	pass


func stop_moving(target: Node2D):
	pass


func start_attacking(target: Node2D):
	if not target is Player or $attack_delay.time_left > 0:
		return
	if is_walking:
		stop_moving(target)
	$attack_delay.start()
	attack()


func stop_attacking(target: Node2D):
	if not target is Player:
		return
	if not is_walking:
		start_moving(target)
	$attack_delay.stop()


func attack():
	pass


func take_damage(amount: int, normal: Vector2):
	health -= amount
	velocity = normal * -knockback
	if health <= 0:
		die()


func die():
	stop_moving(target_body)
	$hitbox.queue_free()
	$sight_radius.queue_free()
	$attack_radius.queue_free()
	$attack_delay.queue_free()
	$body_sprite.play("death")
#	$tween.interpolate_property($body_sprite, "shader_param/progress", 0.0, 1.0, 1.0)#, Tween.TRANS_LINEAR, Tween.EASE_OUT)
#	$tween.start()
	$tween.interpolate_property(self, "shader_progress", 0.0, 1.0, 1.0)
	$tween.start()
	yield($tween, "tween_completed")
	queue_free()


func _on_hitbox_area_entered(area: Area2D):
	#print(area)
	if area is Projectile:
		take_damage(area.contact_damage, global_position.direction_to(area.global_position))
	if area.get_parent() is Player:
		var player = area.get_parent()
		player.take_damage(contact_damage, global_position.direction_to(player.global_position))
