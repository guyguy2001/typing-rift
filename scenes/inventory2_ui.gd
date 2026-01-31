extends Control

@export var inventory: Inventory2

@onready var cost_line: CostLine = $CostLine

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(self.inventory != null)
	self.inventory.updated.connect(self._on_inventory_updated)
	_on_inventory_updated()


func _on_inventory_updated() -> void:
	cost_line.update_cost(inventory.items)
	
