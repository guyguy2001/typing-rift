extends Sprite2D

@export var inventory: Inventory
@export var needed_item: Item

@onready var target = $Target

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(self.needed_item != null)
	assert(self.inventory != null)
	target.on_reached.connect(self._activate)

func _activate(player: Player) -> void:
	if player.inventory.item_type == self.needed_item:
		if player.inventory.try_transfer_to(self.inventory, needed_item, null):
			print("Guardian accepted the", self.needed_item.name)
		else:
			print("Failed to transfer item to guardian's inventory")
	else:
		print("Player does not have the needed item:", self.needed_item.name)
