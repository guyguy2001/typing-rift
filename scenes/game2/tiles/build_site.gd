extends Node2D

@onready var target: Target = $Target

func _ready() -> void:
	assert(target != null)
	self.target.on_reached.connect(_try_build)
	target.word = WordsManagerG.get_word()
	BuildingManagerG.building_selected.connect(self._on_building_selected)


func _on_building_selected(_index: int, _building_data: BuildingData) -> void:
	# Big todo!!! Should this be in a builder component?
	# Check if the player's approach component is pointing here
	var player: Player = get_tree().get_first_node_in_group("player")
	if player.approach_comp.target == self.target and not player.approach_comp.active:
		print("Player is already at this tile, trying to build")
		self._try_build(player)
	

func _try_build(player: Player) -> void:
	print("try build")
	var buildable := BuildingManagerG.get_selected_building()
	if buildable == null:
		print("No building selected!")
		return

	var inventory := player.inventory as Inventory2
	assert(inventory != null)
	if not inventory.try_pay(buildable.cost):
		print("Not enough resources to build!")
		return

	var b := buildable.scene.instantiate() as Node2D
	self.get_parent().add_child(b)
	b.position = self.position

	self.queue_free()
	BuildingManagerG.deselect_building()
