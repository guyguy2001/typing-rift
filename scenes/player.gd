extends Node2D

class_name Player

@export var target: Node2D = null:
	set(value):
		# TODO: This should probably be a signal listener?
		target = value
		approach_comp.start_chasing(target)
@export var inventory: Inventory

@onready var approach_comp: ApproachComponent = $ApproachComponent
@onready var auto_attack_comp: AutoAttackComponent = $AutoAttackComponent

func _ready() -> void:
	assert(inventory != null)
	assert(approach_comp != null)
	assert(auto_attack_comp != null)
	self.approach_comp.reached_target.connect(self._on_reached_target)

func _on_reached_target(_who: Node2D, target_: Target) -> void:
	self.target = null
	target_.on_reached.emit(self) # ????
	print("oofoidjfi")
	if target_.parent.is_in_group("enemy"):
		print("Player reached enemy target, starting auto-attack")
		self.auto_attack_comp.target = target_.parent
		self.auto_attack_comp.start()
	
