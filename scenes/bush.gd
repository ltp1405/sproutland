extends StaticBody2D

@onready var RED_BERRY_TEXTURE = preload("res://resources/red_berry_texture.tres")
@onready var RED_BERRY_ITEM = preload("res://resources/items/red_berry.tres")
@onready var ITEM = preload("res://scenes/item.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	grow_berry()
	await get_tree().create_timer(2).timeout
	harvest()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func grow_berry() -> void:
	var berries = $Berries.get_children().filter(func(node): return node is Sprite2D)
	for berry in berries:
		berry.texture = RED_BERRY_TEXTURE
		

func harvest() -> void:
	var berries = $Berries.get_children().filter(func(node): return node is Sprite2D)
	for berry in berries:
		var tween = get_tree().create_tween()
		tween.tween_property(berry, "position", berry.position + Vector2(0, -5.0), 0.1).set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(berry, "position", berry.position + Vector2(0, 9.0), 0.3).set_trans(Tween.TRANS_CUBIC)
		tween.tween_callback(berry.queue_free)
		tween.tween_callback(_spawn_berry_fn(berry.global_position + Vector2(0, 9.0)))


func _spawn_berry_fn(position):
	var _spawn = func():
		var item: Item = ITEM.instantiate()
		item.data = RED_BERRY_ITEM
		item.z_index = z_index
		get_parent().add_child(item)
		item.global_position = position
	return _spawn
