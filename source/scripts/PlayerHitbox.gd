class_name PlayerHitbox
extends Area2D

@onready var collision_shape = $CollisionShape2D
func _init() -> void:
	collision_layer = 2
	collision_mask = 0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass
func set_disabled(is_disabled: bool) -> void:
	collision_shape.set_deferred("disabled", is_disabled)
