extends Control

func set_health(amount: int):
	$hp_bar.value = amount


func set_ammo(amount: float):
	$ammo_bar.value = amount


func set_dash(amount: int):
	if amount >= 0 and amount < $dash_bar.texture.frames:
		$dash_bar.texture.set_current_frame(amount)
