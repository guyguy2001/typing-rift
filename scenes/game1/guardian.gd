extends Sprite2D

@export var inventory: Inventory
@export var needed_item: Item
@export var attack_damage: float = 15.0
@export var attack_cooldown: float = 1.0

@onready var target: Target = $Target

var RADIUS: float = 500.0
var RADIUS_SQUARED: float = RADIUS * RADIUS
var attack_timer: float = 0.0

const SHOT_SCENE = preload("res://scenes/shot.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(self.needed_item != null)
	assert(self.inventory != null)

	# target.on_reached.connect(self._activate)

# func _activate(player: Player) -> void:
# 	if player.inventory.item_type == self.needed_item:
# 		if player.inventory.try_transfer_to(self.inventory, needed_item, null):
# 			print("Guardian accepted the", self.needed_item.name)
# 		else:
# 			print("Failed to transfer item to guardian's inventory")
# 	else:
# 		print("Player does not have the needed item:", self.needed_item.name)

func _process(delta: float) -> void:
	attack_timer -= delta
	_attack_timeout()

func _attack_timeout() -> void:
	var enemies := get_tree().get_nodes_in_group("enemy")
	for enemy: Node in enemies:
		assert(enemy is Node2D)
		if is_instance_valid(enemy):
			var distance_squared := global_position.distance_squared_to((enemy as Node2D).global_position)
			if distance_squared <= RADIUS_SQUARED:
				if attack_timer <= 0.0:
					_fire_at(enemy as Node2D)
					attack_timer = attack_cooldown

func _fire_at(enemy: Node2D) -> void:
	# Create shot visual effect
	var shot := SHOT_SCENE.instantiate() as Shot
	shot.source = self
	shot.dest = enemy
	get_tree().root.add_child(shot)
	
	# Deal damage to enemy
	var health_component: HealthComponent = enemy.get_node("HealthComponent")
	if health_component != null:
		health_component.damage(attack_damage)
	else:
		print("ERROR: Enemy has no HealthComponent!")
	
func _draw() -> void:
	draw_circle(Vector2.ZERO, RADIUS, Color8(255, 0, 0, 50), false, 1, true)
