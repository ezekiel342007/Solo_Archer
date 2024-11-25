extends NodeState

@onready var level1 = $"../.."
@onready var enemies_node: Node = %Enemies
@onready var camera: GameCamera = %Camera2D
@onready var player: CharacterBody2D = %Player
@onready var game_screen: CanvasLayer = %GameScreen
@onready var entry_point: Node = $"../../EntryPoints"
@onready var wave_trigger: RayCast2D = $"../../WaveTrigger"
@onready var tree: StaticBody2D = $"../../Environment/Trees/Tree"
@onready var compass = preload("res://Assets/UI/Compass/compass.tscn")
@onready var tnt_goblin = preload("res://Characters/Goblins/TNTGoblin/tnt_goblin.tscn")
@onready var restart_menu = preload("res://Assets/UI/RestartOptions/restart_menu.tscn")
@onready var spawn_effect: PackedScene = preload("res://Assets/effects/spawn_effect.tscn")
@onready var player_health_bar = preload("res://Assets/UI/PlayerHealthBar/player_health_bar.tscn")

var enemy_node: Node
var enemy_counter: EnemyCounter
var surviving_commoner: Commoner
var level_complete: bool = false
var spawn_effects: Array[Node] = []
var should_spawn_goblins: bool = true


func enter() -> void:
	print("phase4")
	level1.phase4 = true
	enemy_node = $"../../Enemies"
	surviving_commoner = $"../../Commoner"
	PlayerManagement.has_died.connect(player_death)
	surviving_commoner.reached_player.connect(end_level)
	direct_to_mob()


func on_physics_process(_delta: float) -> void:
	if surviving_commoner != null:
		if camera.get_viewport_rect().abs().has_point(camera.to_local(surviving_commoner.global_position)):
			print("is is view")
			surviving_commoner.flee_scene()

	if (wave_trigger.is_colliding() and wave_trigger.get_collider() is Player) and (should_spawn_goblins == true and level1.phase4):
		should_spawn_goblins = false
		if get_node("/root/Level1/Player/Compass") != null:
			get_node("/root/Level1/Player/Compass").queue_free()

		spawn_goblins()
		player.add_child(player_health_bar.instantiate())

		if game_screen.margin_container.get_node("EnemyCounter") == null:
			game_screen.margin_container.add_child(EnemyCounter.new(enemies_node))

		if game_screen.margin_container.get_children().size() != 0:
			enemy_counter = game_screen.margin_container.get_child(0)
			if enemy_counter.enemy_count == 0:
				surviving_commoner.run_to(player)


func on_input(event):
	if event is InputEventKey and event.pressed:
		if level_complete == false:
			pass
		else:
			get_tree().change_scene_to_file("res://Assets/Dialogue Scene/dialogue_scene.tscn")


# Provide direction to mob after player has killed the tutorial goblin
func direct_to_mob() -> void:
	var compass_instance = compass.instantiate()
	compass_instance.target_position = tree.global_position
	game_screen.margin_container.add_child(level1.deploy_narration_banner(Messages.phase4_instruction))
	player.add_child(compass_instance)


func spawn_goblins() -> void:
	var entry_points: Array[Node] = entry_point.get_children()
	for i in range(4):
		for point in entry_points:
			make_spawn_effect(point)
			await get_tree().create_timer(1.0).timeout


func make_spawn_effect(point: Node) -> void:
	var spawn_effect_instance: AnimatedSprite2D = spawn_effect.instantiate()
	spawn_effect_instance.animation_finished.connect(make_goblin.bind(point, spawn_effect_instance.name))
	spawn_effect_instance.global_position = point.global_position
	enemy_node.add_child(spawn_effect_instance)


func make_goblin(point: Node, spawn_effect_name: String) -> void:
	print("making goblin")
	var tnt_gobliin_instance = tnt_goblin.instantiate()
	tnt_gobliin_instance.global_position = point.global_position
	tnt_gobliin_instance.level = "Level1"
	enemy_node.add_child(tnt_gobliin_instance)
	var spawn = enemy_node.get_node(spawn_effect_name)
	spawn.queue_free()


func player_death() -> void:
	player.queue_free()
	var restart_menu_instance: ColorRect = restart_menu.instantiate() as ColorRect
	restart_menu_instance.failed_level = level1.scene_file_path
	game_screen.margin_container.add_child(restart_menu_instance)


func end_level() -> void:
	if enemy_counter.enemy_count == 0:
		game_screen.margin_container.add_child(
			level1.deploy_narration_banner(
				Message.Instruction.new("Level Complete", "")
			)
		)


func exit() -> void:
	level1.phase4 = false
	queue_free()
