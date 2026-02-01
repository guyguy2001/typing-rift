extends BaseInventory

class_name Inventory2

@export var items: Dictionary[Item, int]

func try_add(item_type: Item, amount: int) -> int:
	if item_type not in items:
		items[item_type] = 0
	items[item_type] += amount
	self.updated.emit()
	return amount
	

func try_transfer_to(target_inventory: BaseInventory, item_type: Item, amount: Variant) -> bool:
	assert(amount != null)
	if amount == null:
		if item_type not in self.items:
			return false
		amount = self.items[item_type]
	assert(amount is int)

	if self.items[item_type] < amount:
		return false  # TODO: Am I sure? not `amount = min(self.items[item_type], amount)`?
	
	var transferred_amount = target_inventory.try_add(item_type, amount)
	if transferred_amount > 0:
		self.items[item_type] -= transferred_amount
		self.updated.emit()
		return true
	
	return false


func try_pay(amonut: Dictionary[Item, int]) -> bool:
	for item_type in amonut.keys():
		if item_type not in self.items or self.items[item_type] < amonut[item_type]:
			return false
	
	for item_type in amonut.keys():
		self.items[item_type] -= amonut[item_type]
	
	self.updated.emit()
	return true
