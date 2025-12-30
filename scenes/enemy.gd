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
		# TODO: Make sure that the start chasing doesn't cost me a frame when the target is already in range
		# maybe do an if on the state here?
		approach_comp.start_chasing(target)

@onready var auto_attack_comp: AutoAttackComponent = $AutoAttackComponent
@onready var approach_comp: ApproachComponent = $ApproachComponent


const TARGET_GROUP = "attackable"

func _ready() -> void:
	assert(auto_attack_comp != null)
	assert(approach_comp != null)
	self.approach_comp.reached_target.connect(self._on_reached_target)

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

func _on_reached_target(_who: Node2D, target_: Node2D) -> void:
	assert(target_ == target)
	self.state = State.ATTACKING
	if self.auto_attack_comp.time_left > 0:
		print("ERROR: Trying to attack while already attacking?")
		return
	self.auto_attack_comp.start()

func _process(_delta: float) -> void:
	if target == null:
		target = _find_closest_target()
	self.approach_comp.active = self.state == State.MOVING
