extends Resource

class_name Sidequest

@export var original_items: Array[String] = []
var items: Array[String] = []

signal item_done(item: String)

func setup(items_) -> void:
	self.original_items = items_
	self.items = items_.duplicate()

func on_word_entered(word: String) -> void:
	if items.size() > 0 and word == items[0]:
		items.pop_at(0)
		item_done.emit(word)
