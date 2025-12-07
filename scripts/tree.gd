extends Node2D

class_name FruitTree

var ITEM = preload("res://scenes/item.tscn")
var APPLE_DATA = preload("res://resources/items/apple.tres")
var WOOD_DATA = preload("res://resources/items/wood.tres")

@export var health: int = 5
@export var have_fruit: bool = true
@export var min_wood_drop = 1
@export var max_wood_drop = 4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$FruitSprite.visible = have_fruit

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$FruitSprite.visible = have_fruit

func drop_fruit() -> void:
	$AnimationPlayer.play("drop_fruit")
	await $AnimationPlayer.animation_finished
	have_fruit = false
	$AnimationPlayer.play("idle")
	
	var drop_points = [
		$FruitDropPosisions/FruitDropPosition1.global_position,
		$FruitDropPosisions/FruitDropPosition2.global_position,
		$FruitDropPosisions/FruitDropPosition3.global_position]
	for point in drop_points:
		var new_fruit: Item = ITEM.instantiate()
		new_fruit.initial_disable_duration = 0.9
		new_fruit.z_index = z_index
		new_fruit.global_position = point
		new_fruit.data = APPLE_DATA
		get_tree().current_scene.add_child(new_fruit)


func _on_fruit_grow_timer_timeout() -> void:
	# drop_fruit()
	pass

func chop(damage: int) -> void:
	if have_fruit:
		drop_fruit()
		return
	if health <= 0:
		return
	$AnimationPlayer.play("shake")
	await $AnimationPlayer.animation_finished
	health -= damage
	if health <= 0:
		$AnimationPlayer.play("fall")
		_spawn_wood()
		await $AnimationPlayer.animation_finished
		
func _spawn_wood():
	var wood_count = randi_range(min_wood_drop, max_wood_drop)
	for _i in range(wood_count):
		var wood_pos = global_position + Vector2(randf(), randf()) * 10
		var wood: Item = ITEM.instantiate()
		wood.data = WOOD_DATA
		get_tree().current_scene.add_child(wood)
		wood.global_position = wood_pos
		wood.z_index = z_index
