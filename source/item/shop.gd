extends Node

@export var items : Array[Item]
var tabBar : TabBar = TabBar.new()

#on loadup

func _ready():
	# Specify the folder path
	var sprites = "res://item_sprites/"
	scan_files_in_directory(sprites)
	#custom defined method to create tabs for us to setup the tab bar for the items
	setup(tabBar)
	tabBar.hide()


func scan_files_in_directory(path: String) -> void:
	# Open the directory
	var dir = Directory.new()
	if dir.open(path) == OK:
		# Iterate through the files in the directory
		while true:
			var file_name = dir.get_next()
			if file_name == "":
				break  # Exit the loop if there are no more files
			# Check if it's a file and print its name
			if dir.current_is_file():
				for item in items:
					if item.name == file_name:
						item.sprite = load(file_name)
				print("File: " + file_name)
		# Close the directory
		dir.close()
	else:
		print("Failed to open directory: " + path)
#when user approaches the shop
func on_collide():
	tabBar.show()
func on_leave():
	tabBar.hide()
func setup(tabBar: TabBar):
	#allow user to go back
	tabBar.add_tab("Exit")
	#allow user to select items
	tabBar.add_tab("Items")
	#allow user to select the quantity of the item.
	tabBar.add_tab("Quantity")
