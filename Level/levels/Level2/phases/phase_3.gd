extends NodeState

@onready var player: Player = %Player;
@onready var level2: BaseLevel = $"../..";
@onready var extras: Node = $"../../Extras";
@onready var camera: GameCamera = %Camera2D;
@onready var game_screen: CanvasLayer = %GameScreen;
@onready var count_down = preload("res://Assets/UI/CountDown/count_down.tscn")


func enter() -> void:
	game_screen.margin_container.add_child(
		level2.deploy_narration_banner(
			level2.phase_3_instructions,
			{
				&"have_shown_message": func ():  make_knights_attack(player);
			}
		)
	)


func deploy_count_down() -> void:
	var count_down_instance = count_down.instantiate();
	count_down_instance.connect(
		"CountDownReached",
		func ():
			game_screen.margin_container.add_child(
				level2.deploy_narration_banner(
					Message.Instruction.new("Level Complete", "Enter or Space", false),
					{
						&"have_shown_message": func (): print("complete");
					}
				)
			)
	);
	game_screen.margin_container.add_child(count_down_instance);


func make_knights_attack(target: Node2D) -> void:
	for knight in extras.get_children():
		knight.target = target;
	deploy_count_down();
