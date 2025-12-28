extends Node2D

@export var speed: float = 200
@export var close_threshold: float = 50
@export var target: Node2D = null

func _process(delta: float) -> void:
	if target:
		position += (target.position - position).normalized() * delta * speed
		if (target.position - position).length() < close_threshold:
			target.set_active()
			target = null
