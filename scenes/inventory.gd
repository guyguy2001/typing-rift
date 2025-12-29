extends Resource

class_name Inventory

@export var item_type: Item = null
@export var amount = 0
@export var capacity: int = -1 # -1 means infinite capacity

signal updated()

func try_add(item_type_: Item, amount_: int) -> int:
	if capacity != -1 and self.amount + amount_ > capacity:
		amount_ = capacity - self.amount
		assert(amount_ >= 0)

	if self.item_type == null or self.item_type == item_type_:
		self.item_type = item_type_
		self.amount += amount_
		self.updated.emit()
		return amount_
	
	return 0


func try_transfer_to(target_inventory: Inventory, amount_: Variant) -> bool:
	if amount_ == null:
		amount_ = self.amount
	assert(amount_ is int)
	if self.item_type == null or self.amount < amount_:
		return false
	
	var transfered_amount = target_inventory.try_add(self.item_type, amount_)
	if transfered_amount > 0:
		self.amount -= transfered_amount
		if self.amount == 0:
			self.item_type = null
		self.updated.emit()
		return true
	
	return false
