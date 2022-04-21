extends StaticBody2D
export var distance: int

func _ready():
	$bolt.max_distance = distance
	
