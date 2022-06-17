extends Node2D

export var player_scene: PackedScene
export var start_position: Vector2
export var player_death_duration: float

var last_checkpoint := start_position
onready var player := create_player()


func _ready():
	$world_environment.environment.glow_enabled = true


func _unhandled_input(event):
	if event.is_action_pressed("open_codex"):
		get_tree().paused = !get_tree().paused
		$canvas_layer/codex.visible = !$canvas_layer/codex.visible


func _on_player_died():
	last_checkpoint = player.last_checkpoint
	yield(get_tree().create_timer(player_death_duration), "timeout")
	create_player()


func create_player() -> Player:
	var player: Player = player_scene.instance()
	$y_sort.add_child(player)
	player.connect("ammo_changed", $canvas_layer/hud, "set_ammo")
	player.connect("health_changed", $canvas_layer/hud, "set_health")
	player.connect("dash_number_changed", $canvas_layer/hud, "set_dash")
	player.connect("died", self, "_on_player_died")
	player.global_position = last_checkpoint
	$camera.target = player
	return player
