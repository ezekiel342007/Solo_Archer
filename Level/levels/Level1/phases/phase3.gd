extends Dialogue

@onready var level1 = $"../.."
@onready var game_screen = %GameScreen
@onready var camera: Camera2D = %Camera2D
@onready var player: CharacterBody2D = %Player
@onready var goblin_spawn_position: Marker2D = $"../../GoblinSpawnPosition"
@onready var goblin = preload("res://Characters/Goblins/BomberGoblin/goblin.tscn")
@onready var enemy_health_bar = preload("res://Assets/HealthBar/enemy_health_bar.tscn")

var i: int = 0
var is_player: bool
var narration_banner
var surviving_commoner
var battle: bool = false
var conversation: bool = true
var goblin_in_game: CharacterBody2D


func enter() -> void:
	level1.phase3 = true
	game_screen.margin_container.add_child(
		level1.deploy_narration_banner(
			null,
			&"have_shown_message",
			emit_transition,
			Messages.phase3_conversation_lines
		)
	)
	surviving_commoner = $"../../Commoner"
	player.can_move = false


func spawn_goblin() -> void:
	var goblin_instance: CharacterBody2D = goblin.instantiate() as CharacterBody2D
	goblin_instance.global_position = goblin_spawn_position.global_position
	get_parent().get_parent().add_child(goblin_instance)
	await get_tree().get_root().child_entered_tree
	goblin_in_game = get_node("../../Goblin")
	var enemy_health_bar_instance = enemy_health_bar.instantiate()
	enemy_health_bar_instance.max_health = 10
	goblin_in_game.add_child(enemy_health_bar_instance)


func emit_transition() -> void:
	emit_signal(&"transition", "Phase4")


func exit() -> void:
	level1.phase3 = false
	player.can_move = true
	goblin_spawn_position.queue_free()
	get_node("../..").child_exiting_tree.disconnect(_on_level_1_child_exiting_tree)
	game_screen.narrating = false


func _on_level_1_child_exiting_tree(node):
	if node.name == "Goblin":
		transition.emit("Phase4")
