extends Node

# This manages spawning enemies based on spawn_order
# The spawner.tscn scene should contain Timer nodes that trigger spawns

@export var spawn_point: Node2D
@export var spawn_order: SpawnOrder

@onready var spawn_timer: Timer = %SpawnTimer
@onready var timer_label: Label = %TimerLabel
@onready var enemy_count_label: Label = %EnemyCountLabel

var wave_number := 0

func _ready() -> void:
	assert(spawn_point != null)
	spawn_timer.timeout.connect(self._spawn_wave)
	spawn_timer.wait_time = spawn_order.waves[0].time_until
	spawn_timer.start()

func _spawn_wave() -> void:
	if wave_number >= spawn_order.waves.size():
		print("You win!!!!")
		return

	var wave = spawn_order.waves[wave_number]
	for enemy_type in wave.spawns:
		for i in range(wave.spawns[enemy_type]):
			_spawn_enemy()

	wave_number += 1

	if wave_number < spawn_order.waves.size():
		spawn_timer.wait_time = spawn_order.waves[wave_number].time_until

func _spawn_enemy() -> void:
	var enemy = spawn_order.enemy_scene.instantiate()
	enemy.global_position = spawn_point.global_position
	get_tree().root.add_child(enemy)


func _process(_delta: float) -> void:
	# TODO: reactiviy
	if wave_number < spawn_order.waves.size():
		timer_label.text = "%.2f" % spawn_timer.time_left
		enemy_count_label.text = "x%d" % spawn_order.waves[wave_number].spawns.values()[0]  # TODO
	else:
		self.visible = false
