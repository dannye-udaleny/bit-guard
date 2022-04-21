extends Node2D

func _ready() -> void:
	InputHandler.connect("exit", self, "_exit")
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _process(delta):
	$cursor.position = get_global_mouse_position()


func _input(event):
	if event.is_action_pressed("shoot"):
		$cursor.play("shoot")
	if event.is_action_pressed("+"):
		$y_sort/player/camera.zoom -= Vector2(0.1 , 0.1)
	if event.is_action_pressed("-"):
		$y_sort/player/camera.zoom += Vector2(0.1 , 0.1)


func _exit() -> void:
	get_tree().quit()


func _on_cursor_animation_finished():
	if $cursor.animation == "shoot" and !Input.is_action_pressed("shoot"):
		$cursor.play("idle")

