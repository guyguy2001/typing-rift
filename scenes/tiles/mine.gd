extends Node2D

@export var resource: Item

var _connected_inventory = null

@onready var target = $Target

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(self.resource != null)
	target.on_reached.connect(self._activate)

# TODO: I could just have this entire script be re-used for forest and mine.
# Is this enough for me, or do I want it to somehow be their component, instead of full on script?
func _on_mined(_word: String) -> void:
	self._connected_inventory.try_add(self.resource, 1)

func _activate(player: Player) -> void:
	self._connected_inventory = player.inventory
	Sidequest.new().basic_setup(
		[WordsManagerG.get_word(), WordsManagerG.get_word(), WordsManagerG.get_word()],
		self._on_mined,
	)
	
