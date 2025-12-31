extends Panel

const buildable_label_scene: PackedScene = preload("res://scenes/game2/buildable_label.tscn")

var selected_child: BuildableLabel = null

@onready var children_container: VBoxContainer = $VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Remove placeholders
	for child in self.children_container.get_children():
		child.queue_free()

	BuildingManagerG.building_selected.connect(self._on_building_selected)
	BuildingManagerG.building_deselected.connect(self._on_building_deselected)

	for building_data in BuildingManagerG.buildings:
		var buildable_label: BuildableLabel = buildable_label_scene.instantiate()
		buildable_label.building_data = building_data
		self.children_container.add_child(buildable_label)

func _on_building_selected(index: int, _building_data: BuildingData) -> void:
	if self.selected_child != null:
		self.selected_child.selected = false

	self.selected_child = children_container.get_child(index)
	self.selected_child.selected = true

func _on_building_deselected() -> void:
	if self.selected_child != null:
		self.selected_child.selected = false
	self.selected_child = null