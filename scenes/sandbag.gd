extends Node2D

@onready var anim_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func handle_damage(damage : int):
	print("SANDBAG HIT: ",damage, " pts of damage")
	anim_player.play("stagger")
	
