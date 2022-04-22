extends StaticBody2D

func _ready():
		$flash.visible = false


func _on_area_area_entered(area):
	if area.is_in_group("thunder_bolt"):
		$flash.visible = true

func _on_area_area_exited(area):
	if area.is_in_group("thunder_bolt"):
		$flash.visible = false
