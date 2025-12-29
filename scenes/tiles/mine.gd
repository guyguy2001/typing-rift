extends Sprite2D

@onready var target = $Target

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	target.on_reached.connect(self._activate)


func _shuffle(arr: Array) -> void:
	for i in range(arr.size()):
		var target_ = randi() % (i + 1)
		var aux = arr[i]
		arr[i] = arr[target_]
		arr[target_] = aux

func _get_words() -> Array[String]:
	var words: Array[String] = ["apple", "foo", "guild", "banana", "coil"]
	_shuffle(words)
	return words.slice(0, 3)

func _on_mined(_word: String) -> void:
	Inventory.copper += 1
	print("Copper: " , Inventory.copper)

func _activate() -> void:
	var sidequest = Sidequest.new()
	sidequest.setup(self._get_words())
	sidequest.item_done.connect(self._on_mined)
	SidequestManager.focus(sidequest)
	