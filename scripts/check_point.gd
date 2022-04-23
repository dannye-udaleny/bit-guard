extends Area2D
export var dash: bool


func _ready():
	pass # Replace with function body.


func _on_check_point_body_entered(body):
	if body.is_in_group("player"):
		if dash:
			body.dash_enable = true
		get_parent().position_player = position
		queue_free()
