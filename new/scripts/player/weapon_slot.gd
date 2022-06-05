extends Node2D

# На всех оружиях в корне должен быть скрипт,
# который расширяет класс Weapon!!!
export (Array, PackedScene) var weapons: Array
#var ammo := [-1] * weapons.size()

var current_index := 0

onready var weapon: Weapon = weapons[0].instance() \
	if weapons.size() > 0 else null


func _ready() -> void:
	add_child(weapon)
	


func _process(_delta: float) -> void:
	look_at(get_global_mouse_position())
	if weapon != null:
		rotation_degrees += weapon.rotation_offset \
			* (-1 if weapon.flip_v else 1)


func set_flipped(flipped: bool) -> void:
	position.x = 4 if flipped else -4
	if weapon != null:
		weapon.set_flipped(flipped)


# -2 - предыдущее оружие
# -1 - следующее оружие
func set_weapon(index: int) -> void:
	match index:
		-2: current_index -= 1
		-1: current_index += 1
		_:  current_index = index
	current_index %= weapons.size()
	var flipped = weapon.flip_v
	if weapon != null:
		weapon.queue_free()
	weapon = weapons[current_index].instance()
	add_child(weapon)
	weapon.set_flipped(flipped)


func mouse_pressed() -> void:
	if weapon != null:
		weapon.mouse_pressed()


func mouse_released() -> void:
	if weapon != null:
		weapon.mouse_released()
