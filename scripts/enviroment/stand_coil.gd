extends StaticBody2D



func _bolt_enter(area):
	if area.is_in_group("bolt"):
		$animated_sprite.visible = true

func _bolt_exited(area):
	if area.is_in_group("bolt"):
		$animated_sprite.visible = false
