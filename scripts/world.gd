extends Node2D

func _ready() -> void:
	InputHandler.connect("exit", self, "_exit")


func _exit() -> void:
	get_tree().quit()
