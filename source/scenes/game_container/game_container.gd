extends Node2D
class_name GameContainer

#easy way to access the GameContainer from other nodes
static var GAME_CONTAINER : GameContainer

#There should only ever be one active scene (menu or stage) and it will be the only child of the ActiveSceneHolder node
@onready var ActiveSceneHolder = $ActiveSceneHolder
#Other scenes should be overlay panels (UI, eg pause menu) can be put in the OverlayPanels node
@onready var OverlayPanels = $OverlayPanels
#The player nodes are instantiated in the Players node, they can be hidden and frozen when necessary
@onready var Players = $Players

#Scenes
@onready var main_menu : PackedScene = preload("res://source/scenes/menus/main_menu.tscn")
@onready var credits : PackedScene = preload("res://source/scenes/menus/credits.tscn")
@onready var instructions : PackedScene = preload("res://source/scenes/menus/instructions.tscn")
@onready var character_select : PackedScene = preload("res://source/scenes/menus/character_select.tscn")
@onready var pre_game_cut_scene : PackedScene = preload("res://source/scenes/cut_scenes/pre_game_cut_scene.tscn")
@onready var shop : PackedScene = preload("res://source/scenes/stages/shop.tscn")
@onready var game_over : PackedScene = preload("res://source/scenes/menus/game_over.tscn")
@onready var stage1 : PackedScene = preload("res://source/scenes/stages/stage1.tscn")
@onready var stage2 : PackedScene = preload("res://source/scenes/stages/stage2.tscn")
@onready var stage3 : PackedScene = preload("res://source/scenes/stages/stage3.tscn")
@onready var stage4 : PackedScene = preload("res://source/scenes/stages/stage4.tscn")
enum Scene {
	MAIN_MENU,
	CREDITS,
	INSTRUCTIONS,
	CHARACTER_SELECT,
	PRE_GAME_CUT_SCENE,
	GAME_OVER,
	SHOP,
	STAGE1,
	STAGE2,
	STAGE3,
	STAGE4,
	RANDOM_STAGE
}

#Scoring
var player_scores : Array[int] = [0,0,0,0]
var winning_score : int = 5

#### METHODS ####

func _ready():
	GAME_CONTAINER = self
	pass

func _process(delta):
	#quit if Q pressed - DEBUG
	if Input.is_key_pressed(KEY_Q) :
		get_tree().quit()
	pass

func switch_to_scene(scene_enum : Scene) :
	#switch_active_scene(getScene(scene_enum))
	#below: debug code, above: actual code
	if scene_enum == Scene.SHOP :
		award_point_to_player(1)
		print("POINTS AWARDED FOR DEBUG PURPOSES")
		if player_scores[0] == winning_score :
			switch_active_scene(game_over)
			player_scores = [0,0,0,0]
		else :
			switch_active_scene(shop)
	else :
		switch_active_scene(getSceneFromEnum(scene_enum))
	

func switch_active_scene(scene : PackedScene) :
	ActiveSceneHolder.get_child(0).queue_free()
	var s = scene.instantiate()
	ActiveSceneHolder.add_child(s)

func getSceneFromEnum(scene_enum : Scene) -> PackedScene:
	match (scene_enum) :
		Scene.MAIN_MENU : return main_menu
		Scene.CREDITS : return credits
		Scene.INSTRUCTIONS : return instructions
		Scene.CHARACTER_SELECT : return character_select
		Scene.PRE_GAME_CUT_SCENE : return pre_game_cut_scene
		Scene.GAME_OVER : return game_over
		Scene.SHOP : return shop
		Scene.STAGE1 : return stage1
		Scene.STAGE2 : return stage2
		Scene.STAGE3 : return stage3
		Scene.STAGE4 : return stage4
		Scene.RANDOM_STAGE : return get_random_stage()
		_ : 
			print("Scene not recognized")
			return main_menu

func get_random_stage() -> PackedScene:
	var r = int(randf() * 4)
	if r == 0 : return stage1
	if r == 1 : return stage2
	if r == 2 : return stage3
	else : return stage4

func award_point_to_player(player : int) :
	player_scores[player-1] += 1

func award_points_to_player(player : int, points : int) :
	player_scores[player-1] += points

func award_points_to_players(points : Array[int]) :
	for i in player_scores.size() :
		player_scores[i] += points[i]
