extends Node

func _process(delta):
	if Input.is_key_pressed(KEY_Q) :
		get_tree().quit()
