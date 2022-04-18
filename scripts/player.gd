extends KinematicBody2D

export var move_speed: float # Максимальная скорость персонажа (px/s)
export (float, 0, 1) var acceleration # Вес интерполяции скорости персонажа (0 - 1)
export var dash_enable: bool = false # Режим рывков (вкл/выкл)
export var dash_speed: int = 1000 # Скорость рывка
export var dash_length: float = 0.2 # Длинна рывка(влияет на таймер рывка и его длину)
export var dash_reload_time: float = 2 # Скорость перезарядки N рывков
export var dash_number: int = 5 # Кол-во возможных зарядов для рывков
export(PackedScene) var dash_effect_scene

var _velocity := Vector2() # Скорость персонажа на данный момент (px/s)
var mouse := Vector2()# Глобальная позиция мыши
var dash_counter = 0 # Кол-во доступных зарядов для рывков
var dash_direction := Vector2() # направление рывка
var state

enum states {
	idle,
	run,
	dash,
	is_dashing,
	dash_ended
}

func _ready() -> void:
	$body_sprite.playing = true
	$body_sprite/body_flash_sprite.playing = true
#	InputHandler.connect("mouse_pressed", self, "_on_mouse_pressed")
#	InputHandler.connect("dash", self, "_dash")
	dash_counter = dash_number
	state = states.idle


func _process(delta: float) -> void:
	$body_sprite/body_flash_sprite.animation = $body_sprite.animation
	$body_sprite/body_flash_sprite.flip_h = $body_sprite.flip_h
	mouse = get_global_mouse_position()
	_turn_to_mouse() # Разворачиваем спрайт игрока по направлению к мыши
	if state == states.idle:
		$label.set_text("idle")
	elif state == states.dash:
		$label.set_text("dash")
	else:
		$label.set_text("run")

func _physics_process(delta: float) -> void:
	_state_machine()
	_move_player() # Перемещения игрока
	_player_animation() # Заявляем функцию по изменению анимаций персонажа
	_dash()
	


func _player_animation() -> void:
	if state == states.idle:
		$body_sprite.animation = "idle"
	else:
		if ((mouse.x > position.x and _velocity.x < 0) or (mouse.x < position.x and _velocity.x > 0)): #Сверяем движется ли персонаж и как именно он движется(спиной/лицом) 
			$body_sprite.animation = "run_back"
		else:
			$body_sprite.animation = "run"


func _turn_to_mouse() -> void:
	if mouse.x > position.x: # Разворачиваем спрайт игрока по направлению к мыши
		$body_sprite.flip_h = false
	elif mouse.x < position.x:
		$body_sprite.flip_h = true


func _move_player() -> void:
	if state == states.dash:
		_create_dash_effect() # Создаем эффект от рывка
		_velocity = dash_direction  # Задаем вектор и скорость рывка
		move_and_slide(_velocity)# Производим рывок
	elif state == states.run:
		_velocity = _velocity.linear_interpolate(InputHandler.input_direction * move_speed, acceleration) # Задаем вектор и скорость перемещения с учетом ускорения
		_velocity = move_and_slide(_velocity) # Плавно движемся по направлению ввода
	elif state == states.idle:
		_velocity = _velocity.linear_interpolate(InputHandler.input_direction * move_speed, acceleration) # Задаем вектор и скорость перемещения с учетом ускорения
		_velocity = move_and_slide(_velocity) # Плавно движемся по направлению ввода


func _state_machine() -> void:
	if state == states.idle:
		if InputHandler.input_direction != Vector2.ZERO:
			state = states.run
	elif state == states.run:
		if Input.is_action_just_pressed("dash") and  dash_enable:
			state = states.dash
		elif InputHandler.input_direction == Vector2.ZERO:
			state = states.idle
	elif state == states.dash_ended:
		if InputHandler.input_direction != Vector2.ZERO:
			state = states.run
		else:
			state = states.idle

#____________________________________________________________________________________________

func _dash() -> void:
	if dash_enable:
		if state == states.dash and dash_counter != 0:
			state = states.is_dashing
			dash_counter -= 1
			dash_direction = InputHandler.input_direction * dash_speed
			$dash_timer.start(dash_length)
			print(dash_direction)


func _create_dash_effect() -> void:
	if state == states.is_dashing:
		var dash_effect_node = dash_effect_scene.instance()
		dash_effect_node.texture = $body_sprite.frames.get_frame($body_sprite.animation, $body_sprite.frame)
		dash_effect_node.position = position + Vector2(1, -22)
		dash_effect_node.flip_h = $body_sprite.flip_h
		get_parent().add_child(dash_effect_node)


func _on_dash_timer_timeout() -> void:
	state = states.dash_ended
	_player_animation()
	if state != states.dash and dash_counter == 0:
		$dash_reload.start(dash_reload_time)


func _on_dash_reload_timeout() -> void:
	dash_counter = dash_number

#____________________________________________________________________________________________
