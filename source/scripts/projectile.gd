class_name Projectile
extends Node2D

@export var speed := 1000.0
@export var lifetime := 1.0
@onready var timer := $lifespan_timer
@onready var hitbox := $PlayerHitbox
@onready var sprite := $Sprite2D
@onready var impact_detector := $ImpactDetector
#direction of projectile
var direction := Vector2.ZERO
var damage = 0;

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
	
func get_damage_from_projectile() -> int:
	return damage;
