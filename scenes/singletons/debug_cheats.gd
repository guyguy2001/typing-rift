extends Node

@export var player: Player
@export var resources: Array[Resource]

var CALLBACKS = {
	"$money": _add_money,
}

func _ready() -> void:
	print("DebugCheats ready")
	InputBufferG.word_submitted.connect(_on_word_submitted)

func _on_word_submitted(word: String) -> void:
	if word in CALLBACKS:
		print("Invoking debug callback for word: ", word)
		CALLBACKS[word].call()

func _add_money() -> void:
	for resource in resources:
		if resource is Item:
			player.inventory.try_add(resource, 10)
