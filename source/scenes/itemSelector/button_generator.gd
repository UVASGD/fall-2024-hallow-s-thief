extends FlowContainer

const resourcePath = "res://source/item/item_resources"
var buttonScene: PackedScene = preload("res://source/scenes/itemSelector/item_button.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func addButton(file_name: String):
	# We'll just assume it's a resource of the correct type for now
	var resource: Item_Res = load(resourcePath + "/" + file_name)
	var button: Item_Button = buttonScene.instantiate()
	add_child(button)
	button.setItem(resource)
