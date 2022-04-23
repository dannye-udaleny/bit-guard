extends Control

onready var player = get_parent().get_node("y_sort/player")

func _ready():
	InputHandler.connect("change_theme", self, "_change_theme")
	InputHandler.connect("change_weapon", self, "_gun_interface_changing")


func _process(delta):
	_dash_interface_changing()
	_ammo_interface_changing()
	_health_interface_changing()


func _dash_interface_changing() -> void:
	if player.dash_counter >= 0:
		$player_stats_interface/dash_bar.texture.set_current_frame(player.dash_counter)


func _ammo_interface_changing() -> void:
	if player.get_node("gun") != null:
		$player_stats_interface/ammo_bar.max_value = player.get_node("gun").bullet_number
		$player_stats_interface/ammo_bar.value = player.get_node("gun").bullet_counter
	pass

func _health_interface_changing() -> void:
	if player.max_health != null:
		$player_stats_interface/health_bar.max_value = player.max_health
		$player_stats_interface/health_bar.value = player.current_health

func _change_theme() -> void:
	if $effect_layer/shader_effect.visible == false:
		$effect_layer/shader_effect.visible = true
		$effect_layer/monitor_effect.visible = true
	else:
		$effect_layer/shader_effect.visible = false
		$effect_layer/monitor_effect.visible = false

func _gun_interface_changing(number : int) -> void:
	$player_stats_interface/guns.visible = true
	$player_stats_interface/guns/hide_gun_interface_timer.start()
	match number:
		1:
			if $player_stats_interface/guns/gun_1.animation != "on":
				$player_stats_interface/guns/gun_2.animation = "off"
				$player_stats_interface/guns/gun_2.scale = Vector2(1.7, 1.7)
				$player_stats_interface/guns/gun_1.animation = "on"
				$player_stats_interface/guns/gun_1.scale = Vector2(2, 2)
		2:
			if $player_stats_interface/guns/gun_2.animation != "on":
				$player_stats_interface/guns/gun_1.animation = "off"
				$player_stats_interface/guns/gun_1.scale = Vector2(1.7, 1.7)
				$player_stats_interface/guns/gun_2.animation = "on"
				$player_stats_interface/guns/gun_2.scale = Vector2(2, 2)
	


func _on_hide_gun_interface_timer_timeout():
	$player_stats_interface/guns.visible = false
	$player_stats_interface/guns.modulate.a = lerp($player_stats_interface/guns.modulate.a, 0, 0.1)
