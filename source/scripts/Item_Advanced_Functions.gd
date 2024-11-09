#THIS IS THE TESTING VERIONS
#DELETE LATER

#class_name Item_Advanced_Functions
extends Node#extend node to allow global script
#THIS NEEDS TO BE SET AS A GLOBAL SCRIPT
#Project > Project Settings > Globals


#Class stores and type of special item functionality

static func damage_increase_start(ps :Player_Test):
	ps.statusEffects.addStatusStartFunction("Damage Buff", (func(x : Player_Test): x.damage += 1).bind(ps))
	ps.statusEffects.addStatusEndFunction("Damage Buff", (func(x : Player_Test): x.damage -= 1).bind(ps))

static func damage_increase(ps :Player_Test):
	ps.statusEffects.giveStatusTimed("Damage Buff",3, StatusEffectManager.OverLapBehavior.REFRESH)

static func shoot_additional_projectile(ps:Player_Test):
	print("let's pretend the player shot an additional projectile")

static func damage_when_on_fire(ps : Player_Test):
	ps.statusEffects.addStatusStartFunction("Fire", func(): ps.damage += 10)
	ps.statusEffects.addStatusEndFunction("Fire", func(): ps.damage -= 10)

static func damage_when_low_health(ps : Player_Test):
	print("Im checking health")
	if(ps.health / ps.maxHealth < .5):
		if(!ps.statusEffects.hasStatus("Damage Buff 2")):
			ps.statusEffects.giveStatus("Damage Buff 2")
	else:
		if(ps.statusEffects.hasStatus("Damage Buff 2")):
			ps.statusEffects.removeStatus("Damage Buff 2")
	
func fire_start(ps : Player_Test):
	ps.statusEffects.giveStatusTimed("FireTick", 0.5, StatusEffectManager.OverLapBehavior.STACK)
func fire_tick_end(ps : Player_Test):
	ps.change_health(-2)
	if(ps.statusEffects.hasStatus("Fire")):
		ps.statusEffects.giveStatusTimed("FireTick", 0.5, StatusEffectManager.OverLapBehavior.STACK)
