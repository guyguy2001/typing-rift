extends Node2D

enum State {
	MOVING,
	ATTACKING
}

@export var speed: float = 100.0
@export var state: State = State.MOVING

var target: Node2D = null

@onready var attack_cooldown: Timer = $AttackCooldown


const TARGET_GROUP = "attackable"

func _ready() -> void:
	attack_cooldown.timeout.connect(self._try_attack)

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
			attack_cooldown.start()
			return

		global_position += direction * speed * delta

func _attacking_state(_delta: float) -> void:
	if target == null:
		target = _find_closest_target()

func _try_attack() -> void:
	print("attack!")
	var health_component: HealthComponent = target.get_node("HealthComponent")
	if health_component != null:
		health_component.damage(10)
	
