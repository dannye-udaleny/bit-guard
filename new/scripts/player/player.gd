extends KinematicBody2D
class_name Player

export var walk_speed: float                       # Максимальная скорость игрока (px/s)
export (float, 0, 1) var acceleration: float       # Вес линейной интерполяции скорости игрока
export var dash_speed: float                       # Скорость движения при рывке (px/s)
export var dash_duration: float                    # Длительность рывка (s)
export var dash_cooldown: float                    # Длительность перезарядки рывка (s)
export var max_health: int                         # Максимальное здоровье игрока (hp)

# Потому что вызовы к get_node дороговаты
onready var input_handler: InputHandler = $input_handler

var _is_walking := false
var velocity := Vector2()


func _ready() -> void:
	$body_sprite.play("idle")
	$body_light.play("idle")

#func _process(_delta : float) -> void:
#	set_current_animation()
#	pass

func _physics_process(_delta: float) -> void:
	var target := input_handler.get_move_direction() * walk_speed
	velocity = move_and_slide(lerp(velocity, target, acceleration))
	if (velocity.length() > 3) != _is_walking:
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


#func set_current_animation() -> void:
#	var animation_vector = input_handler.get_move_direction()
#	if _is_walking:
#		var flip = $body_sprite.flip_h == (velocity.x > 0)
#		$body_sprite.play("run", flip)
#		$body_light.play("run", flip)
#	else:
#		$body_sprite.play("idle")
#		$body_light.play("idle")
#
