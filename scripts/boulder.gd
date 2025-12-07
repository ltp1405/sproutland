extends StaticBody2D

@export_enum("default", "with_moss") var variant: String = "default"

const ANIMATION_OFFSETS = {
	"default": Vector2(0, 0),
	"with_moss": Vector2(0, -6),
}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.animation = variant
	$AnimatedSprite2D.offset = ANIMATION_OFFSETS[variant]
