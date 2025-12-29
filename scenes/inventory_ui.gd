extends Panel

@export var inventory: Inventory

@onready var texture = $TextureRect
@onready var amount_label = $Amount

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(self.inventory != null)
	self.inventory.updated.connect(self._on_inventory_updated)
	_on_inventory_updated()


func _on_inventory_updated() -> void:
	if self.inventory.item_type != null:
		self.texture.texture = self.inventory.item_type.icon
		self.amount_label.text = str(self.inventory.amount) if self.inventory.amount >= 1 else ""
	else:
		self.texture.texture = null
		self.amount_label.text = ""
