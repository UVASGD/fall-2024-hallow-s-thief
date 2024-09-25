extends Node

@export var items: Array[Resource]

const Player_Stats = preload("res://Player_Stats.gd")

var player_stats :Player_Stats


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		return
