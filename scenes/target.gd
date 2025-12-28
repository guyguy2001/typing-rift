extends Node2D

@export var word: String

@onready var label : TypableLabel = $TypableLabel

func _ready() -> void:
	self.label.target_text = word
	InputBufferG.word_submitted.connect(_on_word_submitted)

func _on_word_submitted(typed_word: String):
	print(1)
	print(word, typed_word)
	if typed_word == word:
		print(2)
		get_tree().get_nodes_in_group("player")[0].target = self

func set_active():
	SidequestManager.focus(["foo", "two"])
