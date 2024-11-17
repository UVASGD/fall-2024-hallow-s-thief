extends Node2D

@export var attackSpeed := 1000.0 #Does nothing right now
@export var lifetime := 0.1 #seconds
@onready var timer := $lifespan_timer #timer for projectile lifespan
@onready var hitbox :=  $PlayerHitbox #universal hitbox

var direction := Vector2.ZERO
var damage = 0
var attackingPlayer 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_as_top_level(true)
	look_at(position + direction)
	#start timer for attacks lifetime
	timer.connect("timeout",self.queue_free)
	timer.start(lifetime)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	#Follows the players position for the duration of attack lifetime
	if (attackingPlayer!=null and attackingPlayer.has_method("getPlayerPosition")):
		position = attackingPlayer.getPlayerPosition()

func set_damage( newDamage : int) -> void:
	damage = newDamage;
func get_damage() -> float:
	return damage
	
func set_attackingPlayer(player: CharacterBody2D) -> void:
	attackingPlayer = player
func get_attackingPlayer() -> CharacterBody2D:
	return attackingPlayer
