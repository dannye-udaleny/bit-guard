extends StaticBody2D



func _bolt_enter(area):
	if area.is_in_group("bolt"):
<<<<<<< Updated upstream
		$animated_sprite.visible = true

func _bolt_exited(area):
	if area.is_in_group("bolt"):
		$animated_sprite.visible = false
=======
		$light.visible = true


func _bolt_exit(area):
	if area.is_in_group("bolt"):
		$light.visible = false
>>>>>>> Stashed changes
