extends NodeState;

@onready var player: Player = %Player;
@onready var level2: BaseLevel = $"../..";
@onready var extras: Node = $"../../Extras";
@onready var camera: GameCamera = %Camera2D;
@onready var game_screen: CanvasLayer = %GameScreen;
@onready var count_down = preload("res://Assets/UI/CountDown/count_down.tscn")
@onready var player_health_bar_scene = preload("res://Assets/UI/PlayerHealthBar/player_health_bar.tscn");


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
			stop_knights_attack();
			game_screen.margin_container.add_child(
				level2.deploy_narration_banner(
					Message.Instruction.new("Level Complete", "Enter or Space", false),
					{
						&"have_shown_message": func (): get_tree().change_scene_to_file("res://Assets/Dialogue Scene/dialogue_scene_2.tscn");
					}
				)
			)
	);
	game_screen.margin_container.add_child(count_down_instance);


func make_knights_attack(target: Node2D) -> void:
	player.add_child(player_health_bar_scene.instantiate());
	for knight in extras.get_children():
		knight.target = target;
	deploy_count_down();


func stop_knights_attack() -> void:
	player.get_node("PlayerHealthBar").queue_free();
	for knight in extras.get_children():
		knight.target = null;
		knight.destination = null;
