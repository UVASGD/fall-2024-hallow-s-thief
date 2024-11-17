extends Node2D

enum {NONE, FRANKENSTEIN, PUMPKIN, WITCH, GHOST}

@onready var player_select_toggles : PackedScene = preload("res://source/gui/player_select_toggles.tscn")
@onready var test = $test
@onready var hbox_container = $HBoxContainer
@onready var player_count : int = 2
@onready var player_classes = [NONE, NONE, NONE, NONE]
@onready var player_insts = []

@onready var player_scene : PackedScene = preload("res://source/scenes/player.tscn")
@onready var settings_scene : PackedScene = preload("res://source/scenes/settings.tscn")
@onready var game_container = get_parent().get_parent()

func _ready():
	add_player()
	add_player()

func _physics_process(_delta: float) -> void:
	#test.text = str("Player Count: ") + str(player_count) + str(" ") + str(player_classes)
	test.text = str("Player Count: ") + str(player_count)
	match(len(player_insts) - 1):
		1:
			player_classes[0] = player_insts[0].value
			player_classes[1] = player_insts[1].value
		2:
			player_classes[0] = player_insts[0].value
			player_classes[1] = player_insts[1].value
			player_classes[2] = player_insts[2].value
		3:
			player_classes[0] = player_insts[0].value
			player_classes[1] = player_insts[1].value
			player_classes[2] = player_insts[2].value
			player_classes[3] = player_insts[3].value

func _on_start_button_pressed() -> void:
	get_parent().get_parent().switch_to_scene("Stage")
	
	for i in player_classes.size():
		if player_classes[i] != 0:
			var player = player_scene.instantiate()
			player.set_meta("player_num", i+1)
			player.position.x = 512/5*(i+1)
			player.position.y = 160
			player.character = player_classes[i]
			get_parent().get_parent().get_node("Players").add_child(player)
	game_container.get_node("Players").set_meta("player_classes", player_classes)
	
	var settings = settings_scene.instantiate()
	settings.visible = false
	settings.scale = Vector2(0.4, 0.4)
	settings.position = Vector2(51.2, 57.6)
	game_container.add_child(settings)
	
	game_container.start_game()

func _on_left_button_1_pressed() -> void:
	player_classes[0] -= 1
func _on_right_button_1_pressed() -> void:
	player_classes[0] += 1

func _on_remove_player_button_pressed() -> void:
	if player_count > 2:
		player_count -= 1
		remove_player()

func _on_add_player_button_pressed() -> void:
	if player_count < 4:
		player_count += 1
		add_player()

func add_player():
	var player_inst = player_select_toggles.instantiate()
	player_inst.global_position = Vector2(0,0)
	hbox_container.add_child(player_inst)
	player_insts.append(player_inst)

func remove_player():
	player_insts[player_count].queue_free()
	player_insts.remove_at(player_count)
	player_classes[player_count] = 0
