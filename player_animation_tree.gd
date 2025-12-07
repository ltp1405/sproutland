extends Node2D

@onready var player: Player = get_owner()
@export var animation_tree: AnimationTree
@onready var playback: AnimationNodeStateMachinePlayback = animation_tree.get("parameters/playback")
signal done_using_tool

var is_using_tool = false
var last_facing_direction = Vector2(0, -1)

func _play(state: String):
	if !is_using_tool:
		playback.get_current_node()
		playback.travel(state)
		is_using_tool = true
		await playback.state_finished
		is_using_tool = false
		playback.travel("Idle")
		done_using_tool.emit()

func play_use_axe():
	_play("Axe")
	
func play_use_water_can():
	_play("Water Can")
	
func play_use_hoe():
	_play("Hoe")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	var idle = !player.velocity
	if !idle:
		last_facing_direction = player.get_last_motion()
	animation_tree.set("parameters/Idle/blend_position", last_facing_direction)
	animation_tree.set("parameters/Run/blend_position", last_facing_direction)
	animation_tree.set("parameters/Axe/blend_position", last_facing_direction)
	animation_tree.set("parameters/Hoe/blend_position", last_facing_direction)
	animation_tree.set("parameters/WaterCan/blend_position", last_facing_direction)
