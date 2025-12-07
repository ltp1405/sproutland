extends Area2D

@export var character: CharacterBody2D
@export var hit_range: float = 9.0

var last_facing_direction = Vector2(0, -1)
var initial_position: Vector2

func _ready() -> void:
	initial_position = position

func _physics_process(delta: float) -> void:
	var idle = !character.velocity
	if !idle:
		last_facing_direction = character.velocity.normalized()
		
	position = initial_position + last_facing_direction * hit_range
