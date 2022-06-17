extends Sprite

export var delay: float
export var lifetime: float  

var dash_effect = load("res://scenes/player/dash_effect.tscn")
var current_depth: int
var player: Player
var shader_progress = 0.0

func _ready() -> void:
	$timer.start(delay)
	$lifetimer.start(lifetime)

func _process(delta):
	material.set_shader_param("progress", shader_progress)
	
func set_depth(depth: int) -> void:
	current_depth = depth
	
func create_next_effect() -> void:
	if player == null:
		return
	$timer.stop()
	if not is_instance_valid(player) or current_depth <= 0:
		return
	var dash_effect_node = dash_effect.instance()
	dash_effect_node.texture = texture
	dash_effect_node.position = player.position + player.velocity.normalized()
	dash_effect_node.flip_h = flip_h
	dash_effect_node.player = player
	dash_effect_node.current_depth = current_depth - 1
	get_parent().add_child(dash_effect_node)

func destroy():
	#print(current_depth)
	queue_free()
