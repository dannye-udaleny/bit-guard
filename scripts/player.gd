extends KinematicBody2D

# Максимальная скорость персонажа (px/s)
export var move_speed: float
# Вес интерполяции скорости персонажа (0 - 1)
export (float, 0, 1) var acceleration

# Скорость персонажа на данный момент (px/s)
var _velocity := Vector2()

onready var _body_pos: Vector2 = $body_sprite.position
onready var camera = $camera


func _ready() -> void:
	$body_sprite.playing = true


func _process(delta: float) -> void:
	var mouse = get_global_mouse_position()
	# Разворачиваем спрайт игрока по направлению к мыши
	if mouse != null:
		if mouse.x > position.x:
			$body_sprite.flip_h = false
			$gun_sprite.flip_h = false
		elif mouse.x < position.x:
			$body_sprite.flip_h = true
			$gun_sprite.flip_h = true


func _physics_process(delta: float) -> void:
	# Плавно движемся по направлению ввода
	_velocity = _velocity.linear_interpolate(InputHandler.input_direction * move_speed, acceleration)
	_velocity = move_and_slide(_velocity)	
	# Заявляем функцию по изменению анимаций персонажа
	_player_animation()
	
		
func _player_animation() -> void:
	var mouse = get_global_mouse_position()
	#Сверяем движется ли персонаж и как именно он движется(спиной/лицом) 
	if _velocity.length() < 5:
		$body_sprite.animation = "idle"
	elif (mouse.x > position.x and _velocity.x < 0) or (mouse.x < position.x and _velocity.x > 0):
		$body_sprite.animation = "run_back"
	else:
		$body_sprite.animation = "run"
		
	#if Input.action_press("shoot"):
		
	
	


func _on_body_sprite_frame_changed():
	if $body_sprite.animation == "run":
		if $body_sprite.frame == 4 or $body_sprite.frame == 8:
			$gun_sprite.position.y += 1 
		else:
			$gun_sprite.position = _body_pos
	elif $body_sprite.animation == "run_back":
		if $body_sprite.frame == 4 or $body_sprite.frame == 0:
			$gun_sprite.position.y += 1 
		else:
			$gun_sprite.position = _body_pos
	elif $body_sprite.animation == "idle":
		if $body_sprite.frame == 2:
			$gun_sprite.position.y += 1
		else:
			$gun_sprite.position = _body_pos
			
