extends Control
class_name Item_Selector

const resourcePath = "res://source/Items_Final/Item_Resources"
var buttonScene: PackedScene = preload("res://source/scenes/itemSelector/item_button.tscn")
var player: Player
@onready var container: FlowContainer = $MarginContainer/VBoxContainer/ScrollContainer/FlowContainer
@onready var label: Label = $MarginContainer/VBoxContainer/Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = true
	var dir = DirAccess.open(resourcePath)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir():
				if file_name.ends_with(".tres"):
					addButton(file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	label.text = "Item Selector (" + player.name + ")"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func setPlayer(entered: Player):
	player = entered
	
func getPlayer():
	return player
	
func addButton(file_name: String):
	# We'll just assume it's a resource of the correct type for now
	var resource: Item = load(resourcePath + "/" + file_name) as Item
	var button: Item_Button = buttonScene.instantiate()
	container.add_child(button)
	button.setItem(resource)
	button.setPlayer(player)
