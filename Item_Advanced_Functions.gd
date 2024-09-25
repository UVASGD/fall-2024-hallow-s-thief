extends Node#extend node to allow global script
#THIS NEEDS TO BE SET AS A GLOBAL SCRIPT
#Project > Project Settings > Globals


#Class stores and type of special item functionality
class Item_Advanced_Functions:
	static func damage_increase(ps):
		ps.damage += 1
		print("I increased ur damage dawg")
	static func shoot_additional_projectile(ps):
		print("let's pretend the player shot an additional projectile")
