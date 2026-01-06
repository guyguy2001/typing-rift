extends Resource

class_name Item

enum Type {
	COPPER,
	IRON,
	STEEL,
	WOOD,
}

@export var icon: Texture = null
@export var name: String = ""
@export var id: Type
