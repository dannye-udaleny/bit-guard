extends KinematicBody2D

# Максимальная скорость персонажа (px/s)
export var move_speed: float
# Вес интерполяции скорости персонажа (0 - 1)
export (float, 0, 1) var acceleration

# Скорость персонажа на данный момент (px/s)
var _velocity := Vector2()

onready var _sprite_pos: Vector2 = $sprite.position


func _ready() -> void:
	$sprite.playing = true


func _process(delta: float) -> void:
	var mouse = get_global_mouse_position()
	# Разворачиваем спрайт игрока по направлению к мыши
	if mouse != null:
		if mouse.x > position.x:
			$sprite.flip_h = false
		elif mouse.x < position.x:
			$sprite.flip_h = true


func _physics_process(delta: float) -> void:
	# Плавно движемся по направлению ввода
	_velocity = _velocity.linear_interpolate(InputHandler.input_direction * move_speed, acceleration)
	_velocity = move_and_slide(_velocity)	
	_player_animation()
	
		
func _player_animation() -> void:
	var mouse = get_global_mouse_position()
	
	if _velocity.length() < 5:
		$sprite.animation = "idle"
	elif (mouse.x > position.x and _velocity.x < 0) or (mouse.x < position.x and _velocity.x > 0):
		$sprite.animation = "run_back"
	else:
		$sprite.animation = "run"
	
	
