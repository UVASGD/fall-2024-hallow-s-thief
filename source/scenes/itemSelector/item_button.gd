extends Button
class_name Item_Button

var item: Item
var player: Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.pressed.connect(self._button_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func setItem(resource: Item):
	self.item = resource
	set_text(resource.name)
	set_button_icon(resource.sprite)
	
func setPlayer(p: Player):
	player = p
	
func _button_pressed():
	var baseScene = get_tree().current_scene
	if (baseScene.name == "DemoRoom"):
		if (player == null):
			print("I couldn't get the Player node!")
			return
		player.items.append(item)
		print("Gave " + player.name + " a " + item.name)
	else:
		print("The current scene is not DemoRoom, so I can't give you items.")
