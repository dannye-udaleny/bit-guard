extends KinematicBody2D

export var move_speed: float # Максимальная скорость персонажа (px/s)
export (float, 0, 1) var acceleration # Вес интерполяции скорости персонажа (0 - 1)
export var dash_enable: bool = false # Режим рывков (вкл/выкл)
export var dash_speed: int = 1000 # Скорость рывка
export var dash_length: float = 0.2 # Длинна рывка(влияет на таймер рывка и его длину)
export var dash_reload_time: float = 3 # Скорость перезарядки N рывков
export var dash_number: int = 5 # Кол-во возможных зарядов для рывков
export(PackedScene) var dash_effect_scene

var _velocity := Vector2() # Скорость персонажа на данный момент (px/s)
var state := str("") # Состояние персонажа  
var mouse := Vector2()# Глобальная позиция мыши
var dash_counter := int() # Кол-во доступных зарядов для рывков
var dash_direction := Vector2() # направление рывка


func _ready() -> void:
	$body_sprite.playing = true
	$body_sprite/body_flash_sprite.playing = true
	
	InputHandler.connect("mouse_pressed", self, "_on_mouse_pressed")
	InputHandler.connect("dash", self, "_dash")
	
	dash_counter = dash_number


func _process(delta: float) -> void:
	$body_sprite/body_flash_sprite.animation = $body_sprite.animation
	
	$body_sprite/body_flash_sprite.flip_h = $body_sprite.flip_h
	var mouse := get_global_mouse_position()
	# Разворачиваем спрайт игрока по направлению к мыши
	if mouse != null:
		if mouse.x > position.x:
			$body_sprite.flip_h = false
#			$gun_sprite.flip_h = false
		elif mouse.x < position.x:
			$body_sprite.flip_h = true
#			$gun_sprite.flip_h = true
	$label.set_text(state)


func _physics_process(delta: float) -> void:
	mouse = get_global_mouse_position()
	if state == "dash":
		_dash()
		_velocity = dash_direction
		_velocity = move_and_slide(_velocity)
	else:
		_velocity = _velocity.linear_interpolate(InputHandler.input_direction * move_speed, acceleration) # Задаем вектор и скорость перемещения с учетом ускорения
		_velocity = move_and_slide(_velocity) # Плавно движемся по направлению ввода
	_player_animation() # Заявляем функцию по изменению анимаций персонажа
	


func _player_animation() -> void:
	if _velocity.length() < 100 and state != "dash":
		$body_sprite.animation = "idle"
		state = "idle"
	elif (mouse.x > position.x and _velocity.x < 0) or (mouse.x < position.x and _velocity.x > 0) and state != "dash": #Сверяем движется ли персонаж и как именно он движется(спиной/лицом) 
		$body_sprite.animation = "run_back"
		state = "run"
	elif state != "dash":
		$body_sprite.animation = "run"
		state = "run"


func _dash() -> void:
	if dash_enable:
		if state == "run" and dash_counter != 0:
			state = "dash"
			dash_direction = InputHandler.input_direction * dash_speed
			$dash_timer.start(dash_length)
		elif state != "dash" and dash_counter == 0:
			$dash_reload.start(dash_reload_time)
	
	if state == "dash":
		var dash_effect_node = dash_effect_scene.instance()
		dash_effect_node.texture = $body_sprite.frames.get_frame($body_sprite.animation, $body_sprite.frame)
		dash_effect_node.position = position + Vector2(1, -22)
		dash_effect_node.flip_h = $body_sprite.flip_h
		get_parent().add_child(dash_effect_node)


func _on_dash_timer_timeout() -> void:
	state = " "
	dash_number -= 1
	_player_animation()
	pass


func _on_dash_reload_timeout() -> void:
	dash_counter = 5
	pass
