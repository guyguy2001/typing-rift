@abstract
extends Resource

class_name BaseInventory

signal updated()

@abstract
func try_add(item_type_: Item, amount_: int) -> int


@abstract
func try_transfer_to(target_inventory: BaseInventory, item_type_: Item, amount_: Variant) -> bool