extends Node2D

class_name Target

@export var word: String:
	set(value):  # TODO: Probably replace with a Ref<String> resource?
		print("Set ", value, " on ", self)
		word = value
		(func(): self.label.target_text = value).call_deferred()

@onready var label : TypableLabel = $TypableLabel
@onready var parent: Node2D = get_parent()

signal on_reached(who: Player)

func _ready() -> void:
	InputBufferG.word_submitted.connect(_on_word_submitted)

func _on_word_submitted(typed_word: String):
	if typed_word == word:
		get_tree().get_nodes_in_group("player")[0].target = self
