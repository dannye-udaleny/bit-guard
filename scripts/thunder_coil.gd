extends StaticBody2D
export var distance: int
export var turn: bool
export var turn_time_on: float = 1.0
export var turn_time_off: float = 1.0

signal change_turn

func _ready():
	$bolt.max_distance = distance
	if turn_time_off != 0:
		if turn:
			$timer.start(turn_time_on)
		else:
			$timer.start(turn_time_off)
		connect("change_turn", self, "_change_turn")


func _physics_process(delta):
	$bolt.max_distance = distance

func _on_timer_timeout():
	if turn:
		turn = false
	else:
		turn = true
	emit_signal("change_turn")


func _change_turn():
	if turn:
		$bolt.enabled = true
		$bolt.visible = true
		$light.visible = true
		$bolt/area/shape.disabled = false
	else:
		$bolt.enabled = false
		$bolt.visible = false
		$light.visible = false
		$bolt/area/shape.disabled = true


