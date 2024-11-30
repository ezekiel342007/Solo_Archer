extends NodeState

@onready var level1: Node = $"../.."
@onready var player: Player = %Player
@onready var camera: GameCamera = %Camera2D
@onready var game_screen: CanvasLayer = %GameScreen

var surviving_commoner: Commoner


func enter() -> void:
	level1.phase5 = true
	surviving_commoner = level1.get_node("Commoner")
	surviving_commoner.global_position = camera.get_viewport_rect().size
	player.can_move = false
	surviving_commoner.run_to(player)
	surviving_commoner.player_detector.body_entered.connect(
		func (node: Node2D): if node.name == "Player": surviving_commoner.state_machine.transition_to("IdleState")
	)
	surviving_commoner.player_detector.body_entered.connect(end_level)


func end_level(node: Node) -> void:
	if node.name == "Player":
		game_screen.margin_container.add_child(
			level1.deploy_narration_banner(
				Message.Instruction.new("Level Complete", "Enter or Space"),
				{
					&"have_shown_message": func (): get_tree().change_scene_to_file("res://Assets/Dialogue Scene/dialogue_scene.tscn")
				}
			)
		)


func exit() -> void:
	level1.phase5 = false
	queue_free()
