extends NodeState

@onready var level1 = $"../.."
@onready var player: CharacterBody2D = %Player
@onready var camera: Camera2D = $"../../Camera2D2"
@onready var game_screen: CanvasLayer = %GameScreen
@onready var entry_point: Node = $"../../EntryPoints"
@onready var wave_trigger: RayCast2D = $"../../WaveTrigger"
@onready var tree: StaticBody2D = $"../../Environment/Trees/Tree"
@onready var compass = preload("res://Assets/UI/Compass/compass.tscn")
@onready var tnt_goblin = preload("res://Characters/Goblins/TNTGoblin/tnt_goblin.tscn")

var enemy_node: Node
var enemy_counter: EnemyCounter
var surviving_commoner: Commoner
var displaying_message: bool = false
var should_spawn_goblins: bool = true


func enter() -> void:
	level1.phase4 = true
	surviving_commoner = $"../../Commoner"
	enemy_node = $"../../Enemies"
	game_screen.narrating = true
	displaying_message = true
	direct_to_mob()


func on_physics_process(_delta: float) -> void:
	if surviving_commoner != null:
		if !camera.get_viewport_rect().has_point(camera.to_local(surviving_commoner.global_position)):
			surviving_commoner.flee = true

	if (wave_trigger.is_colliding() and wave_trigger.get_collider() is Player) and (should_spawn_goblins == true and level1.phase4):
		should_spawn_goblins = false
		if get_node("/root/Level1/Player/Compass") != null:
			get_node("/root/Level1/Player/Compass").queue_free()

		spawn_goblins()

		if game_screen.margin_container.get_node("HBoxContainer/EnemyCounter") == null:
			game_screen.margin_container.get_node("HBoxContainer").add_child(EnemyCounter.new("../../../../../Enemies"))

	if game_screen.margin_container.get_node("HBoxContainer").get_children().size() != 0:
		enemy_counter = game_screen.margin_container.get_node("HBoxContainer").get_child(0)
		print(enemy_counter.enemy_count)
		if enemy_counter.enemy_count == 0:
			surviving_commoner.run_to_player = true


func on_input(event):
	if event is InputEventKey and event.pressed:
		game_screen.narrating = false


# Provide direction to mob after player has killed the tutorial goblin
func direct_to_mob() -> void:
	var compass_instance = compass.instantiate()
	compass_instance.target_position = tree.global_position
	game_screen.narration_text = "There are others, follow the arrow"
	player.add_child(compass_instance)


func spawn_goblins() -> void:
	var entry_points: Array[Node] = entry_point.get_children()
	for i in range(4):
		for point in entry_points:
			var tnt_gobliin_instance = tnt_goblin.instantiate()
			tnt_gobliin_instance.global_position = point.global_position
			tnt_gobliin_instance.level = "Level1"
			enemy_node.add_child(tnt_gobliin_instance)
			await get_tree().create_timer(1.0).timeout


func exit() -> void:
	level1.phase4 = false
