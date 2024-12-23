extends NodeState

@onready var player: Player = %Player
@onready var level2: BaseLevel = $"../.."
@onready var extras: Node = $"../../Extras"
@onready var camera: GameCamera = %Camera2D
@onready var game_screen: CanvasLayer = %GameScreen
@onready var meeting_point: Marker2D = $"../../MeetingPoint"
@onready var knight_positions: Node = $"../../KnightPositions"
@onready var meeting_point_area: Area2D = $"../../MeetingPoint/Area2D"
@onready var compass_scene: PackedScene = preload("res://Assets/UI/Compass/compass.tscn")

var compass_in_world: Marker2D;


func enter() -> void:
	compass_in_world = deploy_compass()
	meeting_point_area.body_entered.connect(
		func (node: Node2D): 
			compass_in_world.queue_free();
			player.can_move = false;
			if node.name == "Player":
				game_screen.margin_container.add_child(
					level2.deploy_narration_banner(
						null,
						{
							&"have_shown_message": func (): player.can_move = true; transition.emit("Phase2")
						},
						Message.make_script(
							level2.phase_1_player_with_commander,
							{
								"Player": player,
								"Captain": extras.get_node("Captain"),
								"Knight1": extras.get_node("Knight1"),
								"Knight2": extras.get_node("Knight2"),
								"Knight3": extras.get_node("Knight3"),
								"Knight4": extras.get_node("Knight4")
							}
						)
					)
				);
				move_knights_to_position(
					extras.get_children(),
					knight_positions.get_children()
				);
	);


func move_knights_to_position(extras_list: Array[Node], knight_markers: Array[Node]) -> void:
	for i in range(extras_list.size()):
		extras_list[i].march_to(knight_markers[i]);


func deploy_compass() -> Marker2D:
	var compass_instance: Sprite2D = compass_scene.instantiate() as Sprite2D;
	compass_instance.target_position = meeting_point.global_position;
	player.add_child(compass_instance);
	return player.get_node("Compass");


func exit() -> void:
	meeting_point.queue_free();
	queue_free();
