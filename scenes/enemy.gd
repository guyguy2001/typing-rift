extends Node2D

@export var speed: float = 100.0

var target: Node2D = null

const TARGET_GROUP = "attackable"

func _find_closest_target() -> Node2D:
	var closest_target: Node2D = null
	var closest_distance_sq = INF
	for target_ in get_tree().get_nodes_in_group(TARGET_GROUP):
		if target_ is Node2D:
			var distance_sq = global_position.distance_squared_to(target_.global_position)
			if distance_sq < closest_distance_sq:
				closest_distance_sq = distance_sq
				closest_target = target_
	return closest_target

func _process(delta: float) -> void:
	if target == null:
		target = _find_closest_target()
	if target != null:
		var direction = (target.global_position - global_position).normalized()
		global_position += direction * speed * delta
