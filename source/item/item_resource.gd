extends Resource
class_name Item_Res

enum Rarity {
	COMMON,
	UNCOMMON,
	RARE,
	LEGENDARY
}

#Info
@export var sprite : Texture
@export var name : String
@export var description : String
@export var rarity : Rarity

#Functions
@export var func_names : Array[String]

#Stats
@export var health : float
@export var topSpeed : float
@export var attackSpeed : float
@export var attackDamage : float
@export var dashCooldown : float
@export var abilityCooldown : float
@export var cost : int


#note that when adding a stat, a few lines need to be added in stats.gd and in get_stats() in this class

func get_stats() -> Stats :
	var s = Stats.new()
	s.health = health
	s.topSpeed = topSpeed
	s.attackSpeed = attackSpeed
	s.attackDamage = attackDamage
	s.dashCooldown = dashCooldown
	s.abilityCooldown = abilityCooldown
	s.cost = cost
	return s

####################################################################
######   ITEM  SPECIFIC  FUNCTIONS    ########################################

#EXAMPLE
"""
static func amulet_of_fear(player : Player) :
	if (player.is_scared) : 
		player.stats.top_speed += 10
"""

#TESTING
static func do_nothing(player : Player) :
	player.stats.top_speed += 10
	print("nothing")
	pass
