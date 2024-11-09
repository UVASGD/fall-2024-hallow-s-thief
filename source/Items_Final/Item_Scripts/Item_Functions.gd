class_name Item_Functions
#Needs to be a global script
extends Node
func fire_start(ps : Player_Test):
	ps.statusEffects.giveStatusTimed("FireTick", 0.5, StatusEffectManager.OverLapBehavior.STACK)
func fire_tick_end(ps : Player_Test):
	ps.change_health(-2)
	if(ps.statusEffects.hasStatus("Fire")):
		ps.statusEffects.giveStatusTimed("FireTick", 0.5, StatusEffectManager.OverLapBehavior.STACK)
