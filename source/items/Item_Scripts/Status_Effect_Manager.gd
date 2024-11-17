class_name StatusEffectManager
extends Node

var statuses : Array[String]
var statusFunctionsStart : Dictionary#[String:Array[Callable]]
var statusFunctionsEnd : Dictionary#[String,Array[Callable]]

var timers : Dictionary#[Timer, String]
#might need to be list of statuses for status effect stacking
enum OverLapBehavior{
	IGNORE,
	REFRESH,
	STACK
}

func setStartingStatusFunctions(ps : Player_Test):
	#Temperary. StatusEffect behavior should be stored elsewhere
	addStatusStartFunction("Fire", Callable(ItemFunctions,"fire_start").bind(ps))
	addStatusEndFunction("FireTick", Callable(ItemFunctions,"fire_tick_end").bind(ps))
	addStatusStartFunction("Poison", Callable(ItemFunctions, "poison_start").bind(ps))
	addStatusEndFunction("PoisonTick", Callable(ItemFunctions,"poison_tick_end").bind(ps))
	addStatusStartFunction("Stun", Callable(ItemFunctions, "stun_start").bind(ps))
	addStatusEndFunction("Stun", Callable(ItemFunctions,"stun_end").bind(ps))
	addStatusStartFunction("Spook", Callable(ItemFunctions, "spook_start").bind(ps))
	addStatusEndFunction("Spook", Callable(ItemFunctions,"spook_end").bind(ps))

func giveStatus(status : String, overlapBehavior : OverLapBehavior = OverLapBehavior.IGNORE) -> void:
	if(statusFunctionsStart.has(status)):
			call_start_functions(status)
	if(hasStatus(status)):
		match overlapBehavior:
			OverLapBehavior.IGNORE:
				pass
			OverLapBehavior.REFRESH:
				removeStatus(status)
				statuses.append(status)
			OverLapBehavior.STACK:
				statuses.append(status)
	else:
		statuses.append(status)
		



func giveStatusTimed(status: String,duration : float, overlapBehavior : OverLapBehavior = OverLapBehavior.IGNORE) -> void:
	if(hasStatus(status)):
		match overlapBehavior:
			OverLapBehavior.IGNORE:
				pass
			OverLapBehavior.REFRESH:
				for t : Timer in timers: #for loop not looking good. maybe we can reorganize the timers 
					if(timers[t] == status):
						remove_timer(t)
						create_timer(status,duration)
			OverLapBehavior.STACK:
				giveStatus(status, overlapBehavior)
				create_timer(status,duration)
	else:
		giveStatus(status, overlapBehavior)
		create_timer(status,duration)

func hasStatus(status: String) -> bool:
	return statuses.has(status)

func create_timer(status : String, duration :float):
	var timer := Timer.new()
	add_child(timer)
	timer.wait_time = duration
	timer.one_shot = true
	timers[timer] = status
	timer.start()
	timer.connect("timeout", Callable(self,"removeStatus").bind(status))
	timer.connect("timeout", Callable(self, "remove_timer").bind(timer))
	timer.connect("timeout", timer.queue_free)

func remove_timer(timer : Timer):
	if(timers.has(timer)):
		timers.erase(timer)
		timer.queue_free()
	else:
		print("tried to remove timer without a that doesnt exist in timers list")

func removeStatus(status: String):
	statuses.erase(status)
	if(statusFunctionsEnd.has(status)):
		call_end_functions(status)
	
	

func addStatusStartFunction(statusName : String, function : Callable):
	if(hasStatus(statusName)):
		function.call()
	if(!statusFunctionsStart.has(statusName)):
		var newFunctions : Array[Callable]
		statusFunctionsStart[statusName] = newFunctions
	statusFunctionsStart[statusName].append(function)
func addStatusEndFunction(statusName : String, function : Callable):
	if(!statusFunctionsEnd.has(statusName)):
		var newFunctions : Array[Callable]
		statusFunctionsEnd[statusName] = newFunctions
	statusFunctionsEnd[statusName].append(function)
func addStatusStartAndEndFunction(statusName : String, startFunction : Callable, endFunction : Callable):
	addStatusStartFunction(statusName, startFunction)
	addStatusEndFunction(statusName, endFunction)
func call_start_functions(status : String) -> void:
	for c in statusFunctionsStart[status]:
		c.call()

func call_end_functions(status : String) -> void:
	for c in statusFunctionsEnd[status]:
		c.call()

func clearAllStatusEffects() -> void:
	for s in statuses:
		removeStatus(s)
