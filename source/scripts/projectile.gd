class_name Projectile
extends Node2D

@export var speed := 1000.0 #speed of projectile
@export var lifetime := 1.0 #seconds
@onready var timer := $lifespan_timer #timer for projectile lifespan
@onready var hitbox := $PlayerHitbox #universal hitbox
@onready var impact_detector := $ImpactDetector # detects collision for proj.

@export var deathParticle : PackedScene

#direction of projectile
var direction := Vector2.ZERO
var damage = 0;
var attackingPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_as_top_level(true)
	look_at(position + direction)
	#start timer for projectiles lifetime
	timer.connect("timeout",self.queue_free)
	timer.start(lifetime)
	#destory projectile if hits a hurtbox
	impact_detector.connect("body_entered",self.destroy_projectile)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += direction*speed*delta #moves the projectile forward
	
func destroy_projectile(_body: Node) -> void:
	queue_free()
	
func get_damage() -> int:
	return damage;
	
func set_damage( newDamage : int) -> void:
	damage = newDamage;
	
func set_speed( newSpeed : float ) -> void:
	speed = newSpeed;

func set_attackingPlayer(player: CharacterBody2D) -> void:
	attackingPlayer = player
	
func get_attackingPlayer() -> CharacterBody2D:
	return attackingPlayer
	
