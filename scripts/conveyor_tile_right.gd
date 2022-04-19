extends AnimatedSprite

onready var current_body

export var direction: Vector2 = Vector2.RIGHT
export var direction_name: int = 1
export var speed: int = 100

func _ready():
	match direction_name:
		1:
			direction = Vector2.RIGHT
		-1:
			direction = Vector2.LEFT
	match animation:
		"midle":
			$moving_area/shape.position = Vector2(32, 32)
			$moving_area/shape.scale = Vector2(0.72, 1)
		"begin":
			if direction == Vector2.RIGHT:
				$moving_area/shape.position = Vector2(49, 32)
				$moving_area/shape.scale = Vector2(0.17, 1)
			else:
				$moving_area/shape.position = Vector2(17, 32)
				$moving_area/shape.scale = Vector2(0.25, 1)
		"end":
			if direction == Vector2.RIGHT:
				$moving_area/shape.position = Vector2(17, 32)
				$moving_area/shape.scale = Vector2(0.25, 1)
			else:
				$moving_area/shape.position = Vector2(49, 32)
				$moving_area/shape.scale = Vector2(0.17, 1)

func _physics_process(delta):
	_move_body()


func _move_body() -> void:
	if current_body != null:
		current_body.move_and_slide(direction * speed)


func _on_moving_area_body_entered(body):
	current_body = body


func _on_moving_area_body_exited(body):
	if current_body != null:
		current_body.move_and_slide(direction) #)
		current_body = null
