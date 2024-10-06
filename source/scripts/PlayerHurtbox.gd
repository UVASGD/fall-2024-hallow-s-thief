class_name PlayerHurtbox
extends Area2D

func _init() -> void:
	collision_layer = 0
	collision_mask = 2

func _ready() -> void:
	connect("area_entered", self._on_area_entered)
	
func _on_area_entered(hitbox: PlayerHitbox):
	#Hurtbox recieves area2d PlayerHitbox
	#check to make sure area2D is not null
	if hitbox == null:
		return
	if hitbox.owner == owner:
		return
	if owner.has_method("handle_damage"):
		owner.handle_damage(owner.stats.attackDamage + 100)
