extends Node2D

@onready var TOOL_AXE = preload("res://scenes/axe.tscn")
@onready var player: Player = $".."
@onready var player_animation: Node2D = $"../PlayerAnimation"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var use_tool = Input.is_action_just_pressed("use_tool")
	if use_tool:
		if player.equipped_tool == player.Tools.AXE:
			$"../PlayerAnimation".play_use_axe()
			player.velocity = Vector2.ZERO
			var axe: Axe = TOOL_AXE.instantiate()
			add_child(axe)
			axe.done_using_axe.connect(_on_tool_done)
			axe.activate(player.get_last_motion().normalized())
		
func _on_tool_done():
	player.use_tool = false
	pass

func _handle_use_water_can(body: Node2D):
	pass


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	player.use_tool = false
