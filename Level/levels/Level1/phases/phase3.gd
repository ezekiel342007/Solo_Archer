extends NodeState

@onready var level1 = $"../.."
@onready var game_screen = %GameScreen
@onready var camera: GameCamera = %Camera2D
@onready var player: CharacterBody2D = %Player
@onready var goblin_spawn_position: Marker2D = $"../../GoblinSpawnPosition"
@onready var goblin = preload("res://Characters/Goblins/BomberGoblin/goblin.tscn")
@onready var enemy_health_bar = preload("res://Assets/HealthBar/enemy_health_bar.tscn")

var i: int = 0
var is_player: bool
var battle: bool = false
var conversation: bool = true
var goblin_in_game: CharacterBody2D
var surviving_commoner: CharacterBody2D


func enter() -> void:
	surviving_commoner = $"../../Commoner"
	level1.phase3 = true
	camera.transition_ended.connect(restore)

	game_screen.margin_container.add_child(
		level1.deploy_narration_banner(
			null,
			{
				&"see_goblin": func (): spawn_goblin(); camera.transition_from(goblin_spawn_position.global_position); 
			},
			Message.make_script(
				level1.phase3_conversation_lines1,
				{"Player": player, "Commoner": surviving_commoner}
			)
		)
	)
	player.can_move = false


func spawn_goblin() -> void:
	var goblin_instance: CharacterBody2D = goblin.instantiate() as CharacterBody2D
	goblin_instance.name = &"test goblin"
	goblin_instance.global_position = goblin_spawn_position.global_position
	get_parent().get_parent().get_node("Enemies").add_child(goblin_instance)
	await get_tree().get_root().child_entered_tree
	goblin_in_game = get_node("../../Enemies/test goblin")
	goblin_in_game.has_died.connect(emit_transition)
	var enemy_health_bar_instance = enemy_health_bar.instantiate()
	enemy_health_bar_instance.max_health = 10
	goblin_in_game.add_child(enemy_health_bar_instance)


func restore() -> void:
	if game_screen.margin_container.get_node("NarrationBanner"):
		pass
	else:
		game_screen.margin_container.add_child(
			level1.deploy_narration_banner(
				null,
				{&"have_shown_message": show_goblin_kill_instructions},
				Message.make_script(
				level1.phase3_conversation_lines2,
				{"Player": player, "Commoner": surviving_commoner}
				)
			)
		)
	camera.transition_ended.disconnect(restore)


func emit_transition() -> void:
	emit_signal(&"transition", "Phase4")


func show_goblin_kill_instructions() -> void:
	player.can_move = true
	game_screen.margin_container.add_child(
		level1.deploy_narration_banner(
			level1.phase3_directions,
		)
	)


func exit() -> void:
	level1.phase3 = false
	goblin_spawn_position.queue_free()
	queue_free()
