extends Resource

class_name Sidequest

enum Mode {
	FINITE,
	INFINITE,	
}

@export var original_items: Array[String] = []
@export var mode: Mode
var items: Array[String] = []

signal item_done(item: String)

func setup(items_: Array[String]) -> void:
	self.original_items = items_
	self.items = items_.duplicate()

func basic_setup(items_: Array[String], callback: Callable) -> void:
	self.setup(items_)
	self.item_done.connect(callback)
	self.mode = Mode.FINITE
	SidequestManager.focus(self)

func _get_word() -> String:
	# TODO: In the future I want to be able to have the caller ask for a specific kind of word -
	# I need to htink of how to pass that in
	return WordsManagerG.get_word()

func basic_inf_setup(callback: Callable) -> void:
	self.mode = Mode.INFINITE
	self.item_done.connect(callback)
	# self.setup(range(5).map(func(_x): self._get_word()))
	self.setup([
		self._get_word(),
		self._get_word(),
		self._get_word(),
		self._get_word(),
		self._get_word(),
	])
	SidequestManager.focus(self)

func on_word_entered(word: String) -> void:
	if items.size() > 0 and word == items[0]:
		items.pop_at(0)
		item_done.emit(word)
		if mode == Mode.INFINITE:
			items.append(self._get_word())
