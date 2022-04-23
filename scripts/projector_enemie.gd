extends Area2D

signal destroy

export var health = 3

var a = 0.0

func _ready():
	connect("destroy", self, "_turn_off")


func _process(delta):
	$pojector_sprite.material.set_shader_param("progress", a)


func _on_projector_area_entered(area):
	if area.is_in_group("bullet"):
		health -= 1
		if health <= 0:
			$tween.interpolate_property(self, "a", 0.0, 1.0, 1.0)
			$tween.start()
			emit_signal("destroy")
		else:
			$flash.frame += 1


func _turn_off():
	$flash.animation = "off"
	$shape.set_deferred("disabled", true)
	$timer.start()


func _on_timer_timeout():
	$flash.animation = "on"
	$flash.frame = 0
	health = 3
	$shape.set_deferred("disabled", false)
	$tween.interpolate_property(self, "a", 1.0, 0.0, 1.0)
	$tween.start()
