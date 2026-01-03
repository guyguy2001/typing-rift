extends Resource

class_name BuildingData

enum ITEM_TYPE {
	COPPER,
	IRON,
	STEEL,
	WOOD,
}

@export var name: String
@export var scene: PackedScene
@export var icon: Texture2D
@export var cost: Dictionary[ITEM_TYPE, int]
