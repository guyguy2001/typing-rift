extends Panel

const TypableLabelScene = preload("res://typing_lib/typable_label.tscn")

@export var sidequest: Sidequest

@onready var container := $VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SidequestManager.focus_changed.connect(self._on_focus_changed)

func _on_focus_changed(sidequest_: Sidequest) -> void:
	self.sidequest = sidequest_
	self.sidequest.item_done.connect(func (_word): self._setup_items())
	self._setup_items()

func _setup_items():
	for child in container.get_children():
		child.queue_free()

	if self.sidequest != null:
		var is_first := true
		for item in self.sidequest.items:
			# TODO: Add a sword, pickaxe icon to the left of the word (or maybe to the right of it, to signify the spacebar?)
			var label: TypableLabel = TypableLabelScene.instantiate()
			label.target_text = item
			label.active = is_first

			self.container.add_child(label)
			is_first = false
