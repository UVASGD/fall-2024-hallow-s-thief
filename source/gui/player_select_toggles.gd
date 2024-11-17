extends Control
class_name PlayerSelectToggles

@onready var sprite : Object = $Sprite2D
@onready var value : int = 1
@onready var pumpkin_texture = preload("res://assets/sprites/pumpkin-select.PNG")
@onready var frankenstein_texture = preload("res://assets/sprites/frankenstein-select.png")
@onready var witch_texture = preload("res://assets/sprites/witch-select.png")
@onready var ghost_texture = preload("res://assets/sprites/ghost-select.png")
@onready var sprite_textures = [pumpkin_texture, frankenstein_texture, witch_texture, ghost_texture]

func _physics_process(_delta: float) -> void:
	sprite.texture = sprite_textures[value-1]
	pass

func _on_left_button_pressed() -> void:
	value -= 1
	if value < 1:
		value = 4

func _on_right_button_pressed() -> void:
	value += 1
	if value > 4:
		value = 1
