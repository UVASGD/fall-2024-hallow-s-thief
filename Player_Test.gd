extends Node

#this is just a test repleca of the player
@export var items: Array[Resource]


var damage :int = 0
var health :int = 0
signal onAttack(player)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#Press enter to get item (currently only the DmgBuffItem)
	if Input.is_action_just_pressed("1"):
		print("Gave Item " + str(items[0].resource_path))
		items[0].apply_item(self)#calling with self seems inefficent design wise
	if Input.is_action_just_pressed("2"):
		print("Gave Item " + str(items[1].resource_path))
		items[1].apply_item(self)	
	#press left mouse to "fire"
	if Input.is_action_just_pressed("mouse_0"):
		print("Just Fired")
		onAttack.emit(self)
		
	#press right mouse to check damage stat
	if Input.is_action_just_pressed("mouse_1"):
		print("damage is " + str(damage))
