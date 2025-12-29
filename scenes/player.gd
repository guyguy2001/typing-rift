extends Node2D

@export var speed: float = 200
@export var close_threshold: float = 50
@export var target: Node2D = null

func _process(delta: float) -> void:
	if target:
		var distance = target.global_position - global_position
		if distance.length() < close_threshold:
			target.on_reached.emit()
			target = null
		else:
			position += distance.normalized() * delta * speed
