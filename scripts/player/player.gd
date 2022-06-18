extends KinematicBody2D
class_name Player

export var walk_speed: float                       # Максимальная скорость игрока (px/s)
export (float, 0, 1) var acceleration: float       # Вес линейной интерполяции скорости игрока
export var dash_speed: float                       # Скорость движения при рывке (px/s)
export var dash_duration: float                    # Длительность рывка (s)
export var dash_cooldown: float                    # Длительность перезарядки рывка (s)
export var dash_count_max: float                   # Количество дэшей
export var dash_reload_time: int                   # Перезарядка дэша
export var dash_effect: PackedScene
export var max_dash_depth: int
export var max_health: int                         # Максимальное здоровье игрока (hp)
export var knockback: float                        # На сколько игрок отталкивается при уроне (px)

var _is_walking := false
var _is_dashing := false
var velocity := Vector2()

var last_checkpoint := Vector2(-9999, -9999)
var conveyors := []

onready var health := max_health
onready var dash_count := dash_count_max
# Потому что вызовы к get_node дороговаты
onready var input_handler: InputHandler = $input_handler

signal health_changed(amount)
signal ammo_changed(amount)
signal dash_number_changed(amount)
signal died


func _ready() -> void:
	if last_checkpoint == Vector2(-9999, -9999):
		last_checkpoint = position
	call_deferred("_after_ready")
	$body_sprite.play("idle")
	$body_light.play("idle")

func _after_ready() -> void:
	emit_signal("dash_number_changed", dash_count_max)
	emit_signal("health_changed", health)
	emit_signal("ammo_changed", 1)


func _physics_process(_delta: float) -> void:
	var target := input_handler.get_move_direction() * walk_speed
	velocity = move_and_slide(lerp(velocity, target, acceleration))
	if not conveyors.empty():
		move_and_slide(get_conveyor_speed())
	if (velocity.length() > 30) != _is_walking:
		set_walking(not _is_walking)


func set_flipped(flipped: bool) -> void:
	$body_sprite.flip_h = flipped
	$body_light.flip_h = flipped
	var flip = flipped == (velocity.x > 0)
	if $body_sprite.animation == "run":
		$body_sprite.play("run", flip)
		$body_light.play("run", flip)


func set_walking(walking: bool) -> void:
	_is_walking = walking
	var flip = $body_sprite.flip_h == (velocity.x > 0)
	if walking:
		$body_sprite.play("run", flip)
		$body_light.play("run", flip)
	else:
		$body_sprite.play("idle")
		$body_light.play("idle")


func _on_legs_area_entered(area: Area2D):
	if area is Conveyor:
		conveyors.append(area)
	elif area.collision_layer & 16 != 0: # ловушки
		take_damage(1, velocity.normalized())
	elif area.collision_layer & 32 != 0: # чекпоинты
		last_checkpoint = area.position


func _on_legs_area_exited(area: Area2D):
	if area is Conveyor:
		conveyors.erase(area)


func get_conveyor_speed():
	var sum := Vector2()
	for conveyor in conveyors:
		sum += (Vector2.RIGHT * conveyor.speed).rotated(conveyor.rotation)
	return sum / conveyors.size()


func take_damage(amount: int, normal: Vector2):
	health -= amount
	emit_signal("health_changed", health)
	normal = normal.normalized()
	velocity = normal * -knockback
	if health <= 0:
		die()


func die():
	# сыграть анимацию смерти на месте игрока
	var animation: DeathAnimation = load("res://scenes/player/death_animation.tscn").instance()
	animation.last_checkpoint = last_checkpoint
	animation.global_position = $body_sprite.global_position + Vector2(-100, 18)
	animation.flip_h = $body_sprite.flip_h
	get_parent().add_child(animation)
	emit_signal("died")
	queue_free()


func dash():
	if dash_count > 0 and input_handler.get_move_direction() != Vector2.ZERO:
		velocity = velocity.normalized() * dash_speed
		dash_count -= 1
		emit_signal("dash_number_changed", dash_count)
		$dash_reload.start(dash_reload_time)
		create_dash_effect()
		set_collision_mask_bit(4, false)
		
		_is_dashing = true
		yield (get_tree().create_timer(dash_duration),"timeout")
		set_collision_mask_bit(4, true)
		_is_dashing = false


func _on_weapon_slot_ammo_changed(amount: float):
	emit_signal("ammo_changed", amount)


func reload_dash():
	if dash_count >= dash_count_max:
		return
	dash_count += 1
	emit_signal("dash_number_changed", dash_count)
	if dash_count < dash_count_max:
		$dash_reload.start(dash_reload_time)


func create_dash_effect() -> void:
	var dash_effect_node = dash_effect.instance()
	dash_effect_node.texture = $body_sprite.frames.get_frame($body_sprite.animation, $body_sprite.frame)
	dash_effect_node.position = position
	dash_effect_node.flip_h = $body_sprite.flip_h
	dash_effect_node.player = self
	dash_effect_node.current_depth = max_dash_depth
	get_parent().add_child(dash_effect_node)
	
