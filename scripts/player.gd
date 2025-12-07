extends CharacterBody2D
class_name Player

@onready var TOOL_AXE = preload("res://scenes/axe.tscn")

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback: AnimationNodeStateMachinePlayback = animation_tree.get("parameters/playback")
var current_tool_node: Node2D = null

var last_facing_direction: Vector2 = Vector2.DOWN
const SPEED = 40.0
var face_direction := "front"

enum Tools { AXE, HOE, WATER_CAN, NONE }
@export var equipped_tool: Tools = Tools.AXE
var using_tool = false

func _physics_process(delta):
	if using_tool:
		velocity = Vector2.ZERO
		
	_process_input()
	_process_blend_position()
	move_and_slide()

	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		# print("I collided with ", collision.get_collider().name)

func _process_input():
	if using_tool:
		return
	var input_direction := Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * SPEED
	if Input.is_action_just_pressed("use_tool"):
		_use_tool()

func _process_blend_position():
	var idle = !velocity
	if !idle:
		last_facing_direction = get_last_motion()
	animation_tree.set("parameters/Idle/blend_position", last_facing_direction)
	animation_tree.set("parameters/Run/blend_position", last_facing_direction)
	animation_tree.set("parameters/Axe/blend_position", last_facing_direction)
	animation_tree.set("parameters/Hoe/blend_position", last_facing_direction)
	animation_tree.set("parameters/WaterCan/blend_position", last_facing_direction)

func _use_tool():
	if !using_tool:
		using_tool = true
		play_use_axe()
		velocity = Vector2.ZERO
		var axe: Axe = TOOL_AXE.instantiate()
		axe.name = "tool"
		add_child(axe)
		current_tool_node = axe
		axe.done_using_axe.connect(_on_tool_done)
		axe.activate(last_facing_direction, 0.4)
	
func _on_tool_done():
	using_tool = false
	playback.travel("Idle")
	if current_tool_node: current_tool_node.queue_free()
	
func _play(state: String):
	playback.travel(state)

func play_use_axe():
	_play("Axe")
	
func play_use_water_can():
	_play("Water Can")
	
func play_use_hoe():
	_play("Hoe")
