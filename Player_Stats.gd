extends Node
enum Stats{Damage, Health}
	
class Player_Stats:
	var damage :int = 0
	var health :int = 0
	func _init(_damage: int, _health:int) -> void:
		damage = _damage
		health = _health
