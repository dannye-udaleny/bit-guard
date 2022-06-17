# "Абстрактный" класс оружия
# Каждая сцена оружия должна иметь в корне скрипт,
# наследующий этот класс
extends AnimatedSprite
class_name Weapon

export var shoot_sound: AudioStream
export var reload_sound: AudioStream
export var rotation_offset: float                  # Отступ вращения (deg)
export var projectile_scene: PackedScene           # Снаряд оружия
export var max_bullets: int                        # Максимальное кол-во патронов в обойме
export var reload_cooldown: float                  # Время перезарядки (s)
export var bullet_speed: float                     # Скорость снаряда (px/s)

var can_shoot := true

signal shot


func mouse_pressed() -> void:
	if $shoot_cooldown.is_stopped() and can_shoot:
		shoot()
		$shoot_cooldown.start()


func mouse_released() -> void:
	play("idle")


func shoot() -> void:
	if not can_shoot or not Input.is_action_pressed("shoot"):
		return
	play("shoot")
	process_shooting()
	$shoot_cooldown.start()
	emit_signal("shot")


func process_shooting() -> void:
	pass


func set_flipped(flipped: bool) -> void:
	flip_v = flipped
	offset.y = 3 if flipped else -3
	$tip.position.y = 1.5 if flipped else -1.5


func start_reload() -> void:
	pass
	
func end_reload() -> void:
	pass
