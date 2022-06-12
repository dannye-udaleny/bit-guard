extends Node2D

# На всех оружиях в корне должен быть скрипт,
# который расширяет класс Weapon!!!
export (Array, PackedScene) var weapons: Array
#var ammo := [-1] * weapons.size()

var current_index := 0
var bullet_count := []

onready var weapon: Weapon = null


func _ready() -> void:
	add_child(weapon)
	
	bullet_count.resize(weapons.size())
	for i in range(weapons.size()):
		bullet_count[i] = -1
	set_weapon(0)


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
	var flipped = weapon.flip_v if weapon != null else false
	if weapon != null:
		weapon.disconnect("shot", self, "_on_weapon_shot")
		weapon.queue_free()
	weapon = weapons[current_index].instance()
	if bullet_count[current_index] == -1:
		bullet_count[current_index] = weapon.max_bullets
	add_child(weapon)
	weapon.connect("shot", self, "_on_weapon_shot")
	weapon.set_flipped(flipped)


func mouse_pressed() -> void:
	if weapon != null and bullet_count[current_index] > 0:
		weapon.mouse_pressed()


func mouse_released() -> void:
	if weapon != null and bullet_count[current_index] > 0:
		weapon.mouse_released()


func _on_weapon_shot() -> void:
	bullet_count[current_index] -= 1
	print(bullet_count[current_index])
	if bullet_count[current_index] <= 0:
		weapon.get_node("shoot_cooldown").stop()
		weapon.mouse_released()