extends Timer

class_name AutoAttackComponent

# TODO: Do I want to raise a signal on attack? No, that would just be a plain timer
@export var attack_damage: float = 10.0
# TODO: Do I want a "targeting" component?
@export var target: Node2D = null

func _ready() -> void:
	self.timeout.connect(self._attack)

func _attack() -> void:
	print("Attack")
	if target == null:
		print("ERROR: No target to attack!")
		return

	var health_component: HealthComponent = target.get_node("HealthComponent")
	if health_component == null:
		print("ERROR: Target has no HealthComponent to attack!")
		return

	print("Damage")
	health_component.damage(attack_damage)
