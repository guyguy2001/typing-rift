extends Node2D


@export var source: Node2D
@export var dest: Node2D
@export var total_time: float = 0.5

@export var opacity: float = 1.0


var source_pos: Vector2
var dest_pos: Vector2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(source != null)
	assert(dest != null)
	source_pos = source.global_position
	dest_pos = dest.global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	opacity -= delta * 1 / total_time
	if source != null:
		source_pos = source.global_position
	if dest != null:
		dest_pos = dest.global_position
	queue_redraw()
	if opacity <= 0:
		queue_free()


func _draw() -> void:
	var color = Color.from_hsv(0.5, 1, 1, opacity)
	draw_line(source_pos, dest_pos, color, 5)
