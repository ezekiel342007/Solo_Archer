extends NodeState

@onready var level1: Node = $"../.."
@onready var player: Player = %Player
@onready var camera: GameCamera = %Camera2D
@onready var game_screen: CanvasLayer = %GameScreen

var surviving_commoner: Commoner


func enter() -> void:
	level1.phase5 = true
	game_screen.enemy_counter_container.get_child(0).queue_free()

	game_screen.margin_container.add_child(
		level1.deploy_narration_banner(
			Message.Instruction.new("Game Complete", "Enter or Space"),
			{
				&"have_shown_message": func (): get_tree().quit()
			}
		)
	)


func exit() -> void:
	level1.phase5 = false
	queue_free()
