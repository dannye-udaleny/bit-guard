extends Control

func set_health(amount: int):
	$hp_bar.value = amount


func set_ammo(amount: float):
	$ammo_bar.value = amount


func set_dash(amount: int):
	$dash_bar.texture.set_current_frame(amount)
