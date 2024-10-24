extends CharacterBody2D

class_name Player

#### item and stats handling (everything else is implemented in the stats_and_item_handler)
@onready var stats_and_item_handler : Node2D = $StatsAndItemHandler
@export var base_stats : Item_Res
var stats : Stats = Stats.new()

@onready var  animation_player = $AnimationPlayer
var Health = stats.health + 1
var Speed := 0.0
var movement := Vector2.ZERO
#enum costumes {FRANKENSTEIN, GHOST, PUMPKIN, WITCH}

const TOP_SPEED_FACTOR := 15.0
const ACCELERATION := 15.0

var isMonster = false;
enum Character {
	WITCH,
	GHOST,
	FRANKENSTEIN,
	PUMPKIN
}
var character = Character.WITCH
#Player has reference to projectile, used by method shoot_projectile
const Projectile_Scene := preload("res://source/scenes/projectile.tscn")

func _ready() -> void:
	pass


func _process(delta) -> void:
	handle_move()
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
	#animation_player.play("Player_Attack")
	shoot_projectile(Projectile_Scene)
	
func handle_damage(damage: int) -> void:
	Health -= damage 
	#print(Health)
func shoot_projectile(projectile: PackedScene) -> void:
	var proj_instance := projectile.instantiate()
	proj_instance.position = self.global_position
	proj_instance.direction = global_position.direction_to(get_global_mouse_position())
	add_child(proj_instance)
