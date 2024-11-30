extends NodeState

@export var enemy_node: Node

@onready var camera: GameCamera = %Camera2D
@onready var level1 = $"../../"
@onready var game_screen: CanvasLayer = %GameScreen


func enter() -> void:
	level1.phase1 = true
	game_screen.margin_container.add_child(
		level1.deploy_narration_banner(
			level1.phase1_level_messages,
			{&"have_shown_message": emit_transition}
		)
	)


func emit_transition() -> void:
	emit_signal(&"transition", "Phase2")


func exit() -> void:
	level1.phase1 = false
	queue_free()
