extends AnimatedSprite


func _ready():
	match animation:
		"midle":
			$moving_area/shape.position = Vector2(32, 32)
			$moving_area/shape.scale = Vector2(1, 1)
		"begin":
			$moving_area/shape.position = Vector2(51, 32)
			$moving_area/shape.scale = Vector2(0.4, 1)
		"end":
			$moving_area/shape.position = Vector2(16, 32)
			$moving_area/shape.scale = Vector2(0.5, 1)



