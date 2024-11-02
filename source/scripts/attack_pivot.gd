extends Node2D

class_name attack_pivot

@onready var  animation_player = $"../AnimationPlayer"
var rotation_speed = 8.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if not (animation_player.is_playing() and animation_player.current_animation == "Player_Attack"):
		#look_at(get_global_mouse_position())
	#else:
	pointTowardsMouseSmooth(delta)

func pointTowardsMouseSmooth(delta: float) -> void:
	var weight = 0.05
	# get vector from player to mouse
	var vect = get_global_mouse_position() - global_position
	# get angle for vector
	var angle = vect.angle()
	# gets current rotation
	var r = global_rotation
	# get rotation allowed for frame
	var max_angle_delta = rotation_speed * delta
	# get complete rotation to mouse
	# Weight effects how fast the rotation occurs, how laggy kinda
	angle = lerp_angle(r, angle, weight)
	# limit the rotation to what is allowed this frame
	# basically sets a limit for the maximum rotation for the fram
	# IGNORE -> var max_rotation_allowed = 1 * max_angle_delta;
	angle = clamp(angle, r - max_angle_delta, r + max_angle_delta)
	# set turret rotation
	global_rotation = angle
	pass
	
func set_rotation_speed(newSpeed: float) -> void:
	rotation_speed = newSpeed

func get_rotation_speed() -> float:
	return rotation_speed
