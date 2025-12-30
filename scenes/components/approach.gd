extends Node

class_name ApproachComponent

@export var close_threshold: float = 50
@export var speed: float = 500

var target: Node2D = null
var active: bool = false

@onready var parent: Node2D = get_parent()

signal reached_target(who: Node2D, target: Node2D)

func _process(delta: float) -> void:
	if target and active:
		var distance := target.global_position - self.parent.global_position
		if distance.length() < close_threshold:
			self.reached_target.emit(self.parent, self.target)
			# target = null  # TODO?
			active = false
		else:
			self.parent.position += distance.normalized() * delta * speed

func start_chasing(new_target: Node2D) -> void:
	target = new_target
	active = true