extends Control

onready var player = get_parent().get_node("y_sort/player")

func _ready():
	InputHandler.connect("change_theme", self, "_change_theme")


func _process(delta):
	_dash_interface_changing()
	_ammo_interface_changing()
	_health_interface_changing()


func _dash_interface_changing() -> void:
	if player.dash_counter >= 0:
		$player_stats_interface/dash_reload.visible = false
		$player_stats_interface/dash_bar.visible = true 
		$player_stats_interface/dash_bar.texture.set_current_frame(player.dash_counter)


func _ammo_interface_changing() -> void:
	pass

func _health_interface_changing() -> void:
	pass

func _change_theme() -> void:
	if $effect_layer/shader_effect.visible == false:
		$effect_layer/shader_effect.visible = true
		$effect_layer/monitor_effect.visible = true
	else:
		$effect_layer/shader_effect.visible = false
		$effect_layer/monitor_effect.visible = false
