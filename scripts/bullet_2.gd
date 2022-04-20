extends Area2D

var direction = Vector2.RIGHT
var speed = 550
var bullet_explosion_scene := preload("res://scenes/nodes/explosion_effect_2.tscn")


func _process(delta: float) -> void:
	translate(direction.normalized() * speed * delta)
	
func _explosion() -> void:
	var explosion = bullet_explosion_scene.instance()
	explosion.position = position
	explosion.rotation = rotation
	get_tree().get_root().add_child(explosion)

func _on_visible_area_screen_exited():
	queue_free()


func _on_bullet_1_body_entered(body):
	_explosion()
	queue_free()
