extends Node2D

class_name Item

@export var item_res : Item_Res

func get_stats() -> Stats :
	return item_res.get_stats()
