extends Sprite2D

@export var float_speed = 2.0
@export var float_height = 10.0

var _initial_y: float
var _time: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_initial_y = position.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_time += delta * float_speed
	var offset_y: float = sin(_time) * float_height
	position.y = _initial_y + offset_y
