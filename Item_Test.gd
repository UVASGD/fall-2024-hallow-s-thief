extends Resource

#basic stats
@export var damage :int
@export var health : int


@export var onFireFunctions : String #Array[String] for multiple on fire functions
#Could exports strings of other events that have item functions
#On hit, On take damage, On every frame

#apply item is called by the player script
func apply_item(ps):
	var c = Callable(ItemAdvancedFunctions.Item_Advanced_Functions,onFireFunctions)
	ps.onAttack.connect(c)
	
	ps.damage += damage
	ps.health += health
#in the future stat changes could be in an array or dictionary in order to not clutter up the inspector with exports
