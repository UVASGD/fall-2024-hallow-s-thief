extends Control
class_name Input_Button

@onready var label = $HBoxContainer/Label as Label
@onready var button = $HBoxContainer/Button as Button

@onready var player_num = get_parent().get_parent().get_meta("player_num")
@onready var input_type = get_parent().get_parent().get_meta("input_type")
@onready var waiting = false
@onready var action

var inputK
var inputJ

var joy_axis = [{1: "L-stick ▶", -1: "L-stick ◀"}, {1: "L-stick ▼", -1: "L-stick ▲"},
				{1: "R-stick ▶", -1: "R-stick ◀"}, {1: "R-stick ▼", -1: "R-stick ▲"},
				{1: "L2 / LT"}, {1: "R2 / RT"}]
var joy_button = ["✕ / A", "◯ / B", "▢ / X", "△ / Y", "Share", "Power", "Options", 
				"L3", "R3", "L1 / LB", "R1 / RB", "D-pad ▲", "D-pad ▼", "D-pad ◀", "D-pad ▶"]

func _ready() -> void:
	label.text = get_meta("input_name")
	action = label.text + str(player_num)
	
	for input in InputMap.action_get_events(action):
		if input is InputEventKey: inputK = input
		else: inputJ = input
	
	InputMap.action_erase_events(action)
	if input_type == "Keyboard": 
		if inputK: InputMap.action_add_event(action, inputK)
	else: InputMap.action_add_event(action, inputJ)
	set_text()

func _process(delta) -> void:
	var cur_input_type = get_parent().get_parent().get_meta("input_type")
	if cur_input_type != input_type:
		InputMap.action_erase_events(action)
		if cur_input_type == "Keyboard": 
			if inputK: InputMap.action_add_event(action, inputK)
		else: InputMap.action_add_event(action, inputJ)
		input_type = cur_input_type
		set_text()

func _on_button_pressed() -> void:
	waiting = true
	button.text = "Press Any Key"

func _input(event):
	if waiting == true:
		if input_type == "Keyboard" && event is InputEventKey || input_type == "Controller" && (event is InputEventJoypadButton || event is InputEventJoypadMotion && abs(event.axis_value) >= 0.5 ):
			if(event is InputEventJoypadMotion):
				if event.axis_value > 0: event.axis_value = 1.00
				else: event.axis_value = -1.00
			
			InputMap.action_erase_events(action)
			InputMap.action_add_event(action, event)
			if input_type == "Keyboard": inputK = event
			else: inputJ = event
			waiting = false
			set_text()

func set_text():
	for input in InputMap.action_get_events(action):
		if input is InputEventKey: inputK = input
		else: inputJ = input
	
	if input_type == "Keyboard":
		if inputK: button.text = str(OS.get_keycode_string(inputK.physical_keycode))
		else: button.text = "---"
	else:
		if inputJ is InputEventJoypadMotion:
			button.text = joy_axis[inputJ.axis][int(inputJ.axis_value)]
		if inputJ is InputEventJoypadButton:
			button.text = joy_button[inputJ.button_index]
