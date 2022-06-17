extends Node2D

func _ready():
	$world_environment.environment.glow_enabled = true


func _unhandled_input(event):
	if event.is_action_pressed("open_codex"):
		get_tree().paused = !get_tree().paused
		$canvas_layer/codex.visible = !$canvas_layer/codex.visible
