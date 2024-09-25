extends Resource

@export var damage :int
@export var health : int
@export var onFireFunctions : String #Array[String] for multiple on fire functions
func apply_item(ps):
	var c = Callable(ItemAdvancedFunctions.Item_Advanced_Functions,onFireFunctions)
	
	ps.onAttack.connect(c)
