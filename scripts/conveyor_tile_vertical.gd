extends AnimatedSprite


export var direction: Vector2 = Vector2.RIGHT
export var direction_name: int = 1
#export var speed: int = 100

var speed = 200
var turn = false

onready var current_body

func _ready():
	match direction_name:
		1:
			direction = Vector2.DOWN
		-1:
			direction = Vector2.UP
	match animation:
		"midle":
			$moving_area/shape.position = Vector2(32, 32)
			$moving_area/shape.scale = Vector2(0.9, 1)
		"begin":
			$moving_area/shape.position = Vector2(32, 32)
			$moving_area/shape.scale = Vector2(0.91, 1)
		"end":
			$moving_area/shape.position = Vector2(32, 32)
			$moving_area/shape.scale = Vector2(0.9, 1)

func _physics_process(delta):
	_move_body()


func _move_body() -> void:
	if current_body != null:
		current_body.move_and_slide(direction * speed)
		if InputHandler.input_direction.y == direction_name:
			speed = 200
			current_body.get_node("speed_effect_v").emitting = true
		elif InputHandler.input_direction.y == -direction_name:
			speed = 60
			current_body.get_node("speed_effect_v").emitting = false
		else:
			speed = 200
			current_body.get_node("speed_effect_v").emitting = false

func _on_moving_area_area_entered(area):
	if area.is_in_group("mooving_body"):
		current_body = area.get_parent()


func _on_moving_area_area_exited(area):
	if area.is_in_group("mooving_body"):
		current_body.get_node("speed_effect_v").emitting = false
		current_body.move_and_slide(direction)
		current_body = null
