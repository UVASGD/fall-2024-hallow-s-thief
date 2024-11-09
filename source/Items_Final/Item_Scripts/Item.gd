extends Resource
class_name Item

enum Rarity {
	COMMON,
	UNCOMMON,
	RARE,
	LEGENDARY
}

enum FunctionTypes
{
	OnStart,
	OnFire,
	OnHit,
	OnGetHit
}

#Info
@export_group("General Information")
@export var sprite : Texture
@export var name : String
@export_multiline var description : String
@export var rarity : Rarity
@export var cost : int


#Stats
@export_group("Stats")
@export var attackDamage: float
@export var attackSpeed: float
@export var maxHealth : float
@export var speed : float
@export var cooldownReduction : float
@export var tenacity : float
@export var luck : float


#Functions
@export_group("Functions")
@export var functionTypes : Array[FunctionTypes]
@export var functionNames : Array[String]
