extends Node2D

enum State {
	MOVING,
	ATTACKING
}

@export var speed: float = 100.0
@export var state: State = State.MOVING

var target: Node2D = null:
	set(value):
		target = value
		auto_attack_comp.target = target

@onready var auto_attack_comp: AutoAttackComponent = $AutoAttackComponent


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
	match state:
		State.MOVING:
			_moving_state(delta)
		State.ATTACKING:
			_attacking_state(delta)

func _moving_state(delta: float) -> void:
	if target == null:
		target = _find_closest_target()
	if target != null:
		var distance = target.global_position - global_position
		var direction = distance.normalized()
		if distance.length() <= 50:
			state = State.ATTACKING
			auto_attack_comp.start()
			return

		global_position += direction * speed * delta

func _attacking_state(_delta: float) -> void:
	if target == null:
		target = _find_closest_target()
