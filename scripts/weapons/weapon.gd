# "Абстрактный" класс оружия
# Каждая сцена оружия должна иметь в корне скрипт,
# наследующий этот класс
extends AnimatedSprite
class_name Weapon

export var rotation_offset: float                  # Отступ вращения (deg)
export var projectile_scene: PackedScene           # Снаряд оружия
export var max_bullets: int                        # Максимальное кол-во патронов в обойме

signal shot


func mouse_pressed() -> void:
	pass


func mouse_released() -> void:
	pass


func set_flipped(_flipped: bool) -> void:
	pass