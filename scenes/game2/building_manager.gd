extends Node

@export var buildings: Array[BuildingData] = []
var selected_index = -1:
	set(value):
		selected_index = value
		if selected_index >= 0:
			self.building_selected.emit(selected_index, buildings[selected_index])
		else:
			self.building_deselected.emit()

signal building_selected(index: int, building_data: BuildingData)
signal building_deselected()

func _ready() -> void:
	InputBufferG.word_submitted.connect(self.on_word_entered)

func on_word_entered(typed_word: String) -> void:
	for i in buildings.size():
		if typed_word == buildings[i].name:
			self.selected_index = i
