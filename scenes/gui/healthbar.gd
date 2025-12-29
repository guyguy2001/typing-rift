extends ProgressBar

@export var health_component: HealthComponent

# Hmmm it would be much sexier if health_component had a "limited_value" resource that would be what this bar would listen to
func _ready() -> void:
	assert(self.health_component != null)
	
	self.health_component.max_health_changed.connect(self._on_max_health_changed)
	self._on_max_health_changed(self.health_component.max_health)

	self.health_component.health_changed.connect(self._on_health_changed)
	self._on_health_changed(self.health_component.health)

func _on_max_health_changed(new_max_health) -> void:
	self.max_value = new_max_health

func _on_health_changed(new_health) -> void:
	self.value = new_health
