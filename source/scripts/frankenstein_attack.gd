extends Node2D

@export var attackSpeed := 1000.0 #speed of projectile
@export var lifetime := 0.1 #seconds
@onready var timer := $lifespan_timer #timer for projectile lifespan
@onready var hitbox :=  $PlayerHitbox #universal hitbox

var direction := Vector2.ZERO
var damage = 0;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_as_top_level(true)
	look_at(position + direction)
	#start timer for attacks lifetime
	timer.connect("timeout",self.queue_free)
	timer.start(lifetime)

#func _process(delta: float) -> void:
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if (owner.has_method("get_position")):
		#position = owner.get_position()
	pass

func set_damage( newDamage : int) -> void:
	damage = newDamage;
	
func get_damage() -> float:
	return damage
