extends NavigationAgent2D

class_name ApproachComponent

@export var close_threshold: float = 50
@export var normal_speed: float = 500
@export var dash_speed: float = 1000

var target: Node2D = null
var active: bool = false
var dashing: bool = false
var _movement_delta := 0.0

@onready var parent: Node2D = get_parent()

signal reached_target(who: Node2D, target: Node2D)

func _ready() -> void:
	# These values need to be adjusted for the actor's speed
	# and the navigation layout.
	self.path_desired_distance = 4.0
	self.target_desired_distance = 4.0
	self.velocity_computed.connect(self._on_velocity_computed)


func start_chasing(new_target: Node2D) -> void:
	target = new_target
	active = true  # TODO: Do I even need my own activate?
	self.set_target_position(new_target.global_position)

func _physics_process(delta: float) -> void:
	if not target or not active:
		return
	# Docs: Do not query when the map has never synchronized and is empty.
	if NavigationServer2D.map_get_iteration_id(self.get_navigation_map()) == 0:
		return
	if self.is_navigation_finished():
		active = false
		self.reached_target.emit(self.parent, self.target)
		return

	var speed := dash_speed if dashing else normal_speed
	self._movement_delta = speed * delta
	var next_path_position: Vector2 = self.get_next_path_position()
	var new_velocity: Vector2 = self.parent.global_position.direction_to(next_path_position) * self._movement_delta
	if self.avoidance_enabled:
		self.set_velocity(new_velocity)
	else:
		_on_velocity_computed(new_velocity)

func _on_velocity_computed(safe_velocity: Vector2) -> void:
	self.parent.global_position = self.parent.global_position.move_toward(self.parent.global_position + safe_velocity, self._movement_delta)
