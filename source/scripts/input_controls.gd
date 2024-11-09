extends Control
class_name Input_Controls

@onready var label = $VBoxContainer/HBoxContainer/Label as Label
@onready var button = $VBoxContainer/HBoxContainer/Button as Button

@onready var player_num = get_meta("player_num")
@onready var input_type = get_meta("input_type")

func _ready() -> void:
	if input_type == "Keyboard": set_meta("device_id", -1)

func _process(delta) -> void:
	input_type = get_meta("input_type")
	button.text = get_meta("input_type")
	
	for node in $VBoxContainer.get_children():
		if node.has_meta("input_name"):
			var inputs = InputMap.action_get_events(node.get_meta("input_name") + str(player_num))
			if len(inputs) > 0:
				if inputs[0] is InputEventJoypadButton || inputs[0] is InputEventJoypadMotion:
					inputs[0].set_device(get_meta("device_id"))

func _on_button_pressed() -> void:
	if input_type == "Keyboard": 
		set_meta("input_type", "Controller")
		set_meta("device_id", 4)
	else:
		set_meta("input_type", "Keyboard")
		set_meta("device_id", -1)
