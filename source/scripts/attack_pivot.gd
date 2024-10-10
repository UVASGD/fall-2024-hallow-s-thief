extends Node2D

@onready var  animation_player = $"../AnimationPlayer"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if not (animation_player.is_playing() and animation_player.current_animation == "Player_Attack"):
		look_at(get_global_mouse_position())
