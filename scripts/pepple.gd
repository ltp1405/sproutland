extends Node2D

@export_enum("tiny", "small", "normal1", "normal2", "random") var variant: String = "tiny"

const ANIMATIONS = ["tiny", "small", "normal1", "normal2"]

func _ready() -> void:
	if variant == "random":
		seed(hash(position.x + position.y))
		$AnimatedSprite2D.animation = ANIMATIONS.pick_random()

func _process(delta: float) -> void:
	pass
