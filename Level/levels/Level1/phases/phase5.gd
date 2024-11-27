extends NodeState

@onready var level1: Node = $"../.."
@onready var game_screen: CanvasLayer = %GameScreen
@onready var camera: GameCamera = %Camera2D
@onready var player: Player = %Player

var surviving_commoner: Commoner

func enter() -> void:
	surviving_commoner = level1.get_node("Commoner")
	surviving_commoner.global_position = camera.global_position
	surviving_commoner.run_to(player)
	surviving_commoner.player_detector.body_entered.connect(end_level)


func end_level() -> void:
	game_screen.margin_container.add_child(
		level1.deploy_narration_banner(
			Message.Instruction.new("Level Complete", "")
		)
	)
