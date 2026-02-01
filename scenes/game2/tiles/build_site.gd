extends Node2D

@onready var target: Target = $Target

func _ready() -> void:
	assert(target != null)
	self.target.on_reached.connect(_try_build)
	target.word = WordsManagerG.get_word()

func _try_build(player: Player) -> void:
	print("try build")
	var buildable := BuildingManagerG.get_selected_building()
	if buildable == null:
		print("No building selected!")
		return

	var inventory = player.inventory as Inventory2
	assert(inventory != null)
	if not inventory.try_pay(buildable.cost):
		print("Not enough resources to build!")
		return

	var b = buildable.scene.instantiate()
	self.get_parent().add_child(b)
	b.position = self.position

	self.queue_free()
	BuildingManagerG.deselect_building()
