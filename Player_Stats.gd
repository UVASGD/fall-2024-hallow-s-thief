extends Node
	

class Player_Stats:
	var damage :int = 0
	var health :int = 0
	signal onFire()
	func _init(_damage: int, _health:int) -> void:
		damage = _damage
		health = _health
