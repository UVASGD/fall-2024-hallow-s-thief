class_name PlayerHurtbox
extends Area2D

func _init() -> void:
	pass
	#collision_layer = 0
	#collision_mask = 2

func _ready() -> void:
	connect("area_entered", self._on_area_entered)
	
func _on_area_entered(hitbox: PlayerHitbox):
	#Hurtbox recieves area2d PlayerHitbox
	#check to make sure area2D is not null
	if hitbox == null:
		#print("NULL!")
		return
	if hitbox.owner == owner:
		#print("this is the owners hitbox")
		return
	if owner.has_method("handle_damage") and hitbox.owner.has_method("get_damage"):
		#need to add check for projectile
		print("PLAYER HIT!")
		owner.handle_damage(hitbox.owner.get_damage())
		#if(hitbox.owner.has_method("get_damage_from_projectile")):
			#print("the hitbox was from a projectile")
			#owner.handle_damage(hitbox.owner.get_damage_from_projectile())
		#else:
			#owner.handle_damage(hitbox.owner.stats.attaackDamage)
