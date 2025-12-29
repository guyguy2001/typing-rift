extends Resource

class_name Inventory

@export var item_type: Item = null
@export var amount = 0

signal updated()

func try_add(item_type_: Item, amount_: int):
    if self.item_type == null or self.item_type == item_type_:
        self.item_type = item_type_
        self.amount += amount_
        emit_signal("updated")
        return true
    
    return false