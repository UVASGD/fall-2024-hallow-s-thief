extends CharacterBody2D

class_name Player

var Speed := 0.0
var movement := Vector2.ZERO

const TOP_SPEED_FACTOR := 15.0
const ACCELERATION := 15.0


func _ready() -> void:
	pass


func _process(delta) -> void:
	handle_move()


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

#### item and stats handling (everything else is implemented in the stats_and_item_handler)
@onready var stats_and_item_handler : Node2D = $StatsAndItemHandler
@export var base_stats : Item_Res
var stats : Stats = Stats.new()

func pickup_item(item : Item) :
	stats_and_item_handler.handle_pickup(item)
	pass

func drop_item(item : Item, destroy : bool) :
	#if destroy is false, you should be reparenting the item
	stats_and_item_handler.handle_drop(item, destroy)
	pass
