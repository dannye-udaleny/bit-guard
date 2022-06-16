extends Area2D
class_name Projectile

export var explosion_scene: PackedScene
export var contact_damage: int

var move_speed := 0.0
var direction := Vector2()


func launch(dir: Vector2, speed: float) -> void:
	direction = dir
	look_at(global_position + direction)
	move_speed = speed


func _physics_process(delta: float) -> void:
	global_translate(direction * move_speed * delta)


func area_entered(_area: Area2D) -> void:
	explode()


func body_entered(_body: Node) -> void:
	explode()


func explode() -> void:
	var explosion: Explosion = explosion_scene.instance()
	$"/root".add_child(explosion)
	explosion.global_position = global_position
	explosion.look_at(global_position + direction)
	queue_free()


func screen_exited() -> void:
	queue_free()
