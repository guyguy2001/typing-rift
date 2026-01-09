extends HBoxContainer

@export var item: Item
@export var amount: int

@onready var icon_texture: TextureRect = $Icon
@onready var amount_label: Label = $Amount

func _ready() -> void:
	assert(item != null)
	icon_texture.texture = item.icon
	amount_label.text = str(amount)
