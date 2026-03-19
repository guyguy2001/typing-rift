extends NavigationAgent2D

class_name ApproachComponent

@export var close_threshold: float = 50
@export var normal_speed: float = 500
@export var dash_speed: float = 1000

var target: Node2D = null
var active: bool = false
var dashing: bool = false

@onready var parent: Node2D = get_parent()
# @onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

signal reached_target(who: Node2D, target: Node2D)

func _ready():
	# assert(navigation_agent != null)
	# These values need to be adjusted for the actor's speed
	# and the navigation layout.
	self.path_desired_distance = 4.0
	self.target_desired_distance = 4.0


func start_chasing(new_target: Node2D) -> void:
	target = new_target
	active = true
	self.set_target_position(new_target.global_position)

func _physics_process(delta):
	if not target or not active:
		return
	if self.is_navigation_finished():
		active = false
		self.reached_target.emit(self.parent, self.target)
		return

	var speed := dash_speed if dashing else normal_speed
	var next_path_position: Vector2 = self.get_next_path_position()
	self.parent.global_position = self.parent.global_position.move_toward(next_path_position, speed * delta)

	# self.parent.velocity = current_agent_position.direction_to(next_path_position) * speed
	# self.parent.move_and_slide()
