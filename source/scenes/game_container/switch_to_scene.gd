extends Button

@export var switch_to : GameContainer.Scene

func _ready() :
	connect("pressed", on_pressed)

func on_pressed() :
	GameContainer.GAME_CONTAINER.switch_to_scene(switch_to)
