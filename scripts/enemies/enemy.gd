extends KinematicBody2D
class_name Enemy

export var health: int               # Здоровье (hp)
export var contact_damage: int       # Урон игроку при соприкосновении с врагом (hp)
export var walk_speed: int           # Скорость врага (px/s)
export var knockback: float          # На сколько враг отталкивается при уроне (px)

var velocity := Vector2()
var target_body: Node2D = null

# Функции для переопределения:
# - start_moving: начать идти в сторону цели (игрока)
# - stop_moving: прекратить идти
# - attack: атаковать цель (игрока)
# в start_moving надо будет задать target_body, в stop_moving сделать его null
# также надо задать спрайты и формы тела и хитбокса


func start_moving(target: Node2D):
	pass


func stop_moving(target: Node2D):
	pass


func start_attacking():
	if $attack_delay.time_left > 0:
		return
	$attack_delay.start()
	attack()


func stop_attacking():
	$attack_delay.stop()


func attack():
	pass


func take_damage(amount: int, normal: Vector2):
	health -= amount
	velocity = normal * -knockback
