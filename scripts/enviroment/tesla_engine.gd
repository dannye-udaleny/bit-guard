extends StaticBody2D

export var turn: bool
export var timing: float

func _ready():
	$lighting.enabled = false
	turn()
	if timing != 0:
		$timer.start(timing)

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
