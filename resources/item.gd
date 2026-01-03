extends Resource

class_name Item

enum ITEM_TYPE {
	COPPER,
	IRON,
	STEEL,
	WOOD,
}

@export var icon: Texture = null
@export var name: String = ""
@export var id: ITEM_TYPE
