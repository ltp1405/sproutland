extends Area2D
class_name Item

@export var data: ItemData
@export var initial_disable_duration = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if data != null:
		$Sprite2D.texture = data.texture
	if initial_disable_duration != 0.0:
		monitoring = false
		await get_tree().create_timer(initial_disable_duration).timeout
		monitoring = true

func _on_body_entered(body: Node2D) -> void:
	if body in get_tree().get_nodes_in_group("player"):
		print("collect item")
		queue_free()
