extends Node2D

@export var word: String

@onready var label : TypableLabel = $TypableLabel

signal on_reached()

func _ready() -> void:
	self.label.target_text = word
	InputBufferG.word_submitted.connect(_on_word_submitted)

func _on_word_submitted(typed_word: String):
	if typed_word == word:
		get_tree().get_nodes_in_group("player")[0].target = self
