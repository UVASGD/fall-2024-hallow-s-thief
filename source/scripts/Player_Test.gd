class_name Player_Test
extends Node

#this is just a test repleca of the player
@export var items: Array[Resource]

var maxHealth : int = 12
var damage :int = 0
var health :int = 12
signal onAttack(player)#This signals will emit every attack
signal onGetHit(player)#This signal will emit every time the player gets hit
#more signals to tell items when to trigger their effects


@onready var statusEffects : StatusEffectManager = $StatusEffectManager

#strictly for testing damage
var testToggle :bool = false



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	manage_test_input()
	if(testToggle):
		print("damage is " + str(damage))
		
func manage_test_input():
	#Press enter to get item (currently only the DmgBuffItem)
	if Input.is_action_just_pressed("1"):
		print("Gave Item " + str(items[0].resource_path))
		get_item(items[0])
	if Input.is_action_just_pressed("2"):
		print("Gave Item " + str(items[1].resource_path))
		get_item(items[1])
	if Input.is_action_just_pressed("3"):
		print("Gave Item " + str(items[2].resource_path))
		get_item(items[2])		
	#press left mouse to "fire"
	if Input.is_action_just_pressed("mouse_0"):
		print("Just Fired")
		onAttack.emit(self)
		#change_health(1)
	#press right mouse to check damage stat
	if Input.is_action_just_pressed("mouse_1"):
		testToggle = !testToggle
	if Input.is_action_just_pressed("ui_accept"):
		statusEffects.giveStatusTimed("Fire",3, StatusEffectManager.OverLapBehavior.STACK)

func get_item(item : Item_Test):
	damage += item.damage
	health += item.health
	if(item.onStartFunctions != ""):
		Callable(ItemAdvancedFunctions, item.onStartFunctions).bind(self).call() #NEED TO DO ERROR HANDLING WHEN USER PASSES STRING THATS NOT A FUNCTION NAME
	if(item.onFireFunctions != ""):
		onAttack.connect(Callable(ItemAdvancedFunctions,item.onFireFunctions))
	if(item.onGetHitFunctions != ""):
		print("new on get hit function: " + item.onGetHitFunctions)
		onGetHit.connect(Callable(ItemAdvancedFunctions,item.onGetHitFunctions))
	
func hit_object(ps: Player_Test):
	pass

func change_health(deltaHealth : float):
	print("Player took " + str(-deltaHealth) + " damage") 
	health += deltaHealth
	onGetHit.emit(self);
	if(health < 0):
		print("You died fool")
#func give_status_effect(effect : StatusEffect, duration : float):
	#statusEffects.giveStatus(effect, duration)
