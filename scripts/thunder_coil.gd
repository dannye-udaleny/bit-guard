extends StaticBody2D

export var distance : float = 100.0
func _ready():
	$bolt.max_distance = distance
