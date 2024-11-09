extends Area2D

var selectorScene: PackedScene = preload("res://source/scenes/itemSelector/item_selector.tscn")
static var singleSelector: Item_Selector = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if singleSelector != null: return
	if body is Player:
		singleSelector = selectorScene.instantiate()
		singleSelector.setPlayer(body)
		get_tree().current_scene.add_child(singleSelector)


func _on_body_exited(body: Node2D) -> void:
	if singleSelector == null: return
	if body is Player and body == singleSelector.getPlayer():
		singleSelector.free()
		singleSelector = null
