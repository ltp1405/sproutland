extends Node2D

class_name Axe

@export var range = 9.0
@export var cooldown = 0.4

signal start_using_axe
signal done_using_axe

var hitbox_initial_position: Vector2

func _ready() -> void:
	hitbox_initial_position = position

func activate(direction: Vector2, delay: float = 0.0) -> void:
	if delay != 0.0:
		await get_tree().create_timer(delay).timeout
	$ToolHitbox.position = position + direction * range
	$ToolHitbox.monitoring = true
	start_using_axe.emit()
	await get_tree().create_timer(cooldown).timeout
	done_using_axe.emit()
	$ToolHitbox.monitoring = false

func _on_tool_hitbox_body_entered(body: Node2D) -> void:
	if body is FruitTree:
		body.chop(1)
	
	$ToolHitbox.set_deferred("monitoring", false)
