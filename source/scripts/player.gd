extends CharacterBody2D

class_name Player

#### item and stats handling (everything else is implemented in the stats_and_item_handler)
@onready var stats_and_item_handler : Node2D = $StatsAndItemHandler
@onready var hurtbox = $AttackPivot/PlayerHitbox
@export var base_stats : Item_Res
var stats : Stats = Stats.new()

var Health = stats.health + 1
var Speed := 0.0
var movement := Vector2.ZERO
#enum costumes {FRANKENSTEIN, GHOST, PUMPKIN, WITCH}

const TOP_SPEED_FACTOR := 15.0
const ACCELERATION := 15.0

var character = costumes.PUMPKIN
#Enemy attack instances
const Projectile_Scene := preload("res://source/scenes/projectile.tscn")
const Frank_Attack_Scene := preload("res://source/scenes/frankenstein_attack.tscn")
const Pumpkin_Attack_Scene := preload("res://source/scenes/pumpkin_attack.tscn")
const Ghost_Attack_Scene := preload("res://source/scenes/ghost_attack.tscn")

#this is just a test repleca of the player
@export var items: Array[Resource]

var maxHealth : int = 12
var damage : int = 0
var topSpeed : int = 10


var health :int = 0
#signal onAttack(player)#This signals will emit every attack
#signal onGetHit(player)#This signal will emit every time the player gets hit
#more signals to tell items when to trigger their effects

var onAttackFunctions : Array[Callable]
var onFireFunctions : Array[Callable]
var onHitFunctions : Array[Callable]
var onGetHitFunctions : Array[Callable]#When this one is called. should also call with the object hit as a parameter

#@onready var statusEffects : StatusEffectManager = $StatusEffectManager

func _ready() -> void:
	pass

func _process(delta) -> void:
	handle_move()
	#if Input.is_action_pressed("Attack"):
	if Input.is_action_just_pressed("Attack"):
		handle_attack()
	if Health <= 0:
		self.queue_free()

func handle_move() -> void:
	var player_num = str(get_meta("player_num"))
	movement = Vector2(Input.get_axis("Left" + player_num, "Right" + player_num), Input.get_axis("Up" + player_num, "Down" + player_num)).normalized()
	
	if movement.length() :
		Speed = move_toward(Speed, topSpeed * TOP_SPEED_FACTOR, ACCELERATION)
	
	if movement.x :
		velocity.x = movement.x * Speed
	else :
		velocity.x = move_toward(velocity.x, 0, ACCELERATION)
	
	if movement.y :
		velocity.y = movement.y * Speed
	else :
		velocity.y = move_toward(velocity.y, 0, ACCELERATION)
	
	move_and_slide()

func get_item(item : Item):
	damage += item.damage
	health += item.health
	
	for i in range(item.FunctionTypes.size()):
		match item.functionTypes[i]:
			Item.FunctionTypes.OnStart:
				Callable(Item_Functions, item.functionNames[i]).bind(self).call()
			Item.FunctionTypes.OnFire:
				onFireFunctions.append(Callable(Item_Functions, item.functionNames[i]).bind(self))
			Item.FunctionTypes.OnHit:
				onHitFunctions.append(Callable(Item_Functions, item.functionNames[i]).bind(self))
			Item.FunctionTypes.OnGetHit:
				onGetHitFunctions.append(Callable(Item_Functions, item.functionNames[i]).bind(self))

func hit_object(ps: Player_Test):
	pass

func drop_item(item : Item, destroy : bool) :
	#if destroy is false, you should be reparenting the item
	stats_and_item_handler.handle_drop(item, destroy)
	pass
	
func handle_attack(): #Right now, just enables, hitbox for 0.5 seconds
	match character:
		costumes.WITCH:
			add_attack_instance_as_child(Projectile_Scene)
		costumes.FRANKENSTEIN:
			add_attack_instance_as_child(Frank_Attack_Scene)
		costumes.GHOST:
			add_attack_instance_as_child(Ghost_Attack_Scene)
		costumes.PUMPKIN:
			add_attack_instance_as_child(Pumpkin_Attack_Scene)
		_:
			print("ERROR: Player not assigned character")
	
	
func handle_damage(attackingPlayer: CharacterBody2D) -> void:
	Health -= attackingPlayer.get_damage()
	 
	

func shoot_projectile(projectile: PackedScene) -> void:
	var proj_instance := projectile.instantiate()
	# set the projectile instance at players locatio
	proj_instance.position = self.global_position
	# set direction of projectile towards mouse
	proj_instance.direction = global_position.direction_to(get_global_mouse_position())
	# assign damage from players stats to projectiles damage
	proj_instance.set_damage(stats.attackDamage)
	# attach attacking player to projectile
	proj_instance.set_attackingPlayer(self)
	#spawn projectile
	add_child(proj_instance)
	
func add_attack_instance_as_child(attack_scene: PackedScene) -> void:
	var attack_instance := attack_scene.instantiate()
	attack_instance.position = self.global_position
	attack_instance.direction = global_position.direction_to(get_global_mouse_position())
	attack_instance.set_damage(stats.attackDamage)
	attack_instance.set_attackingPlayer(self)
	add_child(attack_instance)
	
	
func getPlayerPosition() -> Vector2:
	return position

func get_damage() -> float:
	return stats.attackDamage
func change_health(deltaHealth : float):
	print("Player took " + str(-deltaHealth) + " damage") 
	health += deltaHealth
	#onGetHit.emit(self);
	call_functions(onGetHitFunctions)
	if(health < 0):
		print("You died fool")

func call_functions(arr : Array[Callable]):
	for i in arr:
		i.call()
