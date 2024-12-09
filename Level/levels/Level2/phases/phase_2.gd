extends NodeState

@onready var player: Player = %Player
@onready var level2: BaseLevel = $"../.."
@onready var extras: Node = $"../../Extras"
@onready var camera: GameCamera = %Camera2D
@onready var game_screen: CanvasLayer = %GameScreen


func enter() -> void:
	get_tree().create_timer(4.0).timeout.connect(
		func ():
			game_screen.margin_container.add_child(
				level2.deploy_narration_banner(
					null,
					{},
					Message.make_script(
						level2.phase_2_player_with_commander2,
						{
							"Player": player,
							"Captain": extras.get_node("Captain"),
							"Knight1": extras.get_node("Knight1"),
							"Knight2": extras.get_node("Knight2"),
							"Knight3": extras.get_node("Knight3"),
							"Knight4": extras.get_node("Knight4"),
						}
					)
				)
			)
	)
