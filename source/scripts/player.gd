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

#var isMonster = false;
enum Character {
	WITCH,
	FRANKENSTEIN,
	GHOST,
	PUMPKIN
}
var character = Character.WITCH
#Enemy attack instances
#Witch
const Projectile_Scene := preload("res://source/scenes/projectile.tscn")
#Frankenstein
const Frank_Attack_Scene := preload("res://source/scenes/frankenstein_attack.tscn")
const Pumpkin_Attack_Scene := preload("res://source/scenes/pumpkin_attack.tscn")
const Ghost_Attack_Scene := preload("res://source/scenes/ghost_attack.tscn")

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
	movement = Vector2(Input.get_axis("Left", "Right"), Input.get_axis("Up", "Down")).normalized()
	if movement.length() :
		Speed = move_toward(Speed, stats.topSpeed * TOP_SPEED_FACTOR, ACCELERATION)
	
	if movement.x :
		velocity.x = movement.x * Speed
	else :
		velocity.x = move_toward(velocity.x, 0, ACCELERATION)
	
	if movement.y :
		velocity.y = movement.y * Speed
	else :
		velocity.y = move_toward(velocity.y, 0, ACCELERATION)
	
	move_and_slide()


func pickup_item(item : Item) :
	stats_and_item_handler.handle_pickup(item)
	pass

func drop_item(item : Item, destroy : bool) :
	#if destroy is false, you should be reparenting the item
	stats_and_item_handler.handle_drop(item, destroy)
	pass
	
func handle_attack(): #Right now, just enables, hitbox for 0.5 seconds
	match character:
		Character.WITCH:
			add_attack_instance_as_child(Projectile_Scene)
		Character.FRANKENSTEIN:
			add_attack_instance_as_child(Frank_Attack_Scene)
		Character.GHOST:
			add_attack_instance_as_child(Ghost_Attack_Scene)
		Character.PUMPKIN:
			add_attack_instance_as_child(Pumpkin_Attack_Scene)
		_:
			print("ERROR: Player not assigned character")
	
	
func handle_damage(damage: int) -> void:
	Health -= damage 
	#print(Health)
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

#func attack_Frankenstein(frank_attack: PackedScene) -> void:
	#var frank_attack_instance := frank_attack.instantiate()
	#frank_attack_instance.position = self.global_position
	#frank_attack_instance.direction = global_position.direction_to(get_global_mouse_position())
	#frank_attack_instance.set_damage(stats.attackDamage)
	#frank_attack_instance.set_attackingPlayer(self)
	##add_child(frank_attack_instance)
	#add_child(frank_attack_instance)

#func attack_Pumpkin(pump_attack: PackedScene) -> void:
	#var pumpkin_attack_instance := pump_attack.instantiate()
	#pumpkin_attack_instance.position = self.global_position
	#pumpkin_attack_instance.direction = global_position.direction_to(get_global_mouse_position())
	#pumpkin_attack_instance.set_damage(stats.attackDamage)
	#pumpkin_attack_instance.set_attackingPlayer(self)
	##add_child(frank_attack_instance)
	#add_child(pumpkin_attack_instance)
	
func add_attack_instance_as_child(attack_scene: PackedScene) -> void:
	var attack_instance := attack_scene.instantiate()
	attack_instance.position = self.global_position
	attack_instance.direction = global_position.direction_to(get_global_mouse_position())
	attack_instance.set_damage(stats.attackDamage)
	attack_instance.set_attackingPlayer(self)
	add_child(attack_instance)
	
	
func getPlayerPosition() -> Vector2:
	return position
