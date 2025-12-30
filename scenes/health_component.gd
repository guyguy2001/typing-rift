extends Node2D

class_name HealthComponent

@export var max_health: float:
	set(value):
		max_health = value
		health = clamp(health, 0.0, max_health)
		self.max_health_changed.emit(max_health)
@export var health: float:
	set(value):
		health = clamp(value, 0.0, max_health)
		self.health_changed.emit(health)

signal max_health_changed(new_max_health: float)
signal health_changed(new_health: float)

func damage(amount: float) -> void:
	health -= amount