extends Area2D

@export var data: CropData
@export var stage: int = 2

func _harvestable():
	return stage == data.grow_steps.size()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.sprite_frames = data.stages
	$AnimatedSprite2D.frame = stage

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
