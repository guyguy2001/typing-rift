extends HBoxContainer

class_name CostLine

const item_amount_scene = preload("res://scenes/game2/ui/item_amount.tscn")

# TODO: Find a way to assert that this is set
@export var cost: Dictionary[Item, int] = {}

func _ready() -> void:
	_redraw()

func update_cost(new_cost: Dictionary[Item, int]) -> void:
	cost = new_cost
	_ready()

func _redraw() -> void:
	for child in get_children():
		child.queue_free()

	for item in cost.keys():
		var label = item_amount_scene.instantiate()
		label.item = item
		label.amount = cost[item]
		add_child(label)
