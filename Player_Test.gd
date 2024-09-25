extends Node

@export var items: Array[Resource]


var damage :int = 0
var health :int = 0
signal onAttack(player)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		print("Gave Item " + str(items[0].resource_path))
		items[0].apply_item(self)
	if Input.is_action_just_pressed("mouse_0"):
		print("Just Fired")
		onAttack.emit(self)
	if Input.is_action_just_pressed("mouse_1"):
		print("damage is " + str(damage))
