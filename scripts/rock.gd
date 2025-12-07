extends StaticBody2D

@export_enum("variant1", "variant2", "variant3", "random") var variant: String = "tiny"

const ANIMATIONS = ["variant1", "variant2", "variant3"]
const COLLISION_RADIUSES = {
	"variant1": 4,
	"variant2": 5,
	"variant3": 7
}

func _ready() -> void:
	if variant == "random":
		seed(hash(position.x + position.y))
		variant = ANIMATIONS.pick_random()
		$AnimatedSprite2D.animation = variant
	var new_shape = CircleShape2D.new()
	new_shape.radius = COLLISION_RADIUSES[variant]
	$CollisionShape2D.shape = new_shape
