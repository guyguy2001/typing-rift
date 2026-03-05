extends Node2D

class_name Player

@export var target: Node2D = null:
	set(value):
		# TODO: This should probably be a signal listener?
		target = value
		approach_comp.start_chasing(target)
@export var inventory: BaseInventory

@onready var approach_comp: ApproachComponent = $ApproachComponent
@onready var auto_attack_comp: AutoAttackComponent = $AutoAttackComponent
@onready var dash_input: TypableLabel = %DashInput

func _ready() -> void:
	assert(inventory != null)
	assert(approach_comp != null)
	assert(auto_attack_comp != null)
	self.approach_comp.reached_target.connect(self._on_reached_target)
	InputBufferG.input_changed.connect(self._on_word_typed)

func _on_reached_target(_who: Node2D, target_: Target) -> void:
	self.target = null
	target_.on_reached.emit(self) # ????
	if target_.parent.is_in_group("enemy"):
		print("Player reached enemy target, starting auto-attack")
		self.auto_attack_comp.target = target_.parent
		self.auto_attack_comp.start()

func _on_word_typed(word: String) -> void:
	# TODO: Where should this sit?
	if word == "dash":
		self._dash()
	
func _dash():
	self.approach_comp.dashing = true
	get_tree().create_timer(0.5).timeout.connect(
		func(): self.approach_comp.dashing = false
	)
