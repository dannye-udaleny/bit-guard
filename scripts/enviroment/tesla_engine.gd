extends StaticBody2D

export var turn: bool
<<<<<<< Updated upstream
export var timing: float

func _ready():
	$lighting.enabled = false
=======
export var timing: int

func _ready():
>>>>>>> Stashed changes
	turn()
	if timing != 0:
		$timer.start(timing)

<<<<<<< Updated upstream
func _process(delta):
	$lighting.enabled = true

func turn():
	if timing == 0.0:
		return
	if !turn:
		turn = !turn
		$light.visible = false
		$lighting.enabled = false
		$lighting.visible = false
	else:
		turn = !turn
		$light.visible = true
		$lighting.enabled = true
		$lighting.visible = true


func _on_timer_timeout():
	turn()
	print("turn")
	$timer.start(timing)
=======

func turn():
	if timing != 0:
		if turn:
			$lighting.enabled = true
			$lighting.visible = true
			$animated_sprite.visible = true
		else:
			$lighting.enabled = false
			$lighting.visible = false
			$animated_sprite.visible = false

func _on_timer_timeout():
	turn = !turn
	turn()
>>>>>>> Stashed changes
