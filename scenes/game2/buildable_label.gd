extends Control

class_name BuildableLabel

@export var building_data: BuildingData
# @export var word: String

var selected: bool = false:
	set(value):
		selected = value
		selected_panel.visible = selected

@onready var selected_panel: Panel = $SelectedPanel
@onready var icon: TextureRect = $HBoxContainer/Icon
@onready var label: TypableLabel = $HBoxContainer/TypableLabel
@onready var cost_line: CostLine = $CostLine

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(selected_panel != null)
	assert(icon != null)
	assert(label != null)
	icon.texture = building_data.icon
	label.target_text = building_data.name
	cost_line.update_cost(building_data.cost)
