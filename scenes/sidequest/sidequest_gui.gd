extends Panel

const TypableLabelScene = preload("res://typing_lib/typable_label.tscn")

@export var items: Array[String] = ["foo", "queue"]

@onready var container := $VBoxContainer

signal item_done(item: String)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self._setup_items()
	InputBufferG.word_submitted.connect(self._on_word_entered)
	SidequestManager.focus_changed.connect(self._on_focus_changed)

func _on_focus_changed(items_: Array[String]):
	self.items = items_
	self._setup_items()

func _on_word_entered(word: String):
	if items.size() > 0 and word == items[0]:
		items.pop_at(0)
		_setup_items()
	# TODO: Do something

func _setup_items():
	for child in container.get_children():
		child.queue_free()

	var is_first := true
	for item in self.items:
		var label: TypableLabel = TypableLabelScene.instantiate()
		label.target_text = item
		label.active = is_first

		self.container.add_child(label)
		is_first = false
