extends NodeState

@onready var player: Player = %Player
@onready var level2: BaseLevel = $"../.."
@onready var extras: Node = $"../../Extras"
@onready var camera: GameCamera = %Camera2D
@onready var game_screen: CanvasLayer = %GameScreen
@onready var compass_scene: PackedScene = preload("res://Assets/UI/Compass/compass.tscn")

var compass_in_world: Marker2D

func enter() -> void:
	compass_in_world = deploy_compass(deploy_marker())
	get_tree().create_timer(4.0).timeout.connect(
		func ():
			player.velocity = Vector2(0.0, 0.0);
			player.can_move = false;
			game_screen.margin_container.add_child(
				level2.deploy_narration_banner(
					null,
					{
						&"have_shown_message": func (): transition.emit("Phase3"); player.can_move = true
					},
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
			);
			move_knights_to_position(
				extras.get_children(),
				[
					Vector2(
						randf_range(player.global_position.x, player.global_position.x * 1.121),
						randf_range(player.global_position.y, player.global_position.y * 1.323)
					),
					Vector2(
						randf_range(player.global_position.x, player.global_position.x * 1.123),
						randf_range(player.global_position.y, player.global_position.y * 1.223)
					),
					Vector2(
						randf_range(player.global_position.x, player.global_position.x * 1.238),
						randf_range(player.global_position.y, player.global_position.y * 1.132)
					),
					Vector2(
						randf_range(player.global_position.x, player.global_position.x * 1.326),
						randf_range(player.global_position.y, player.global_position.y * 1.316)
					),
					Vector2(
						randf_range(player.global_position.x, player.global_position.x * 1.323),
						randf_range(player.global_position.y, player.global_position.y * 1.142)
					)
				]
			);
	);


func move_knights_to_position(extras_list: Array[Node], location: Array[Vector2]) -> void:
	for i in range(extras_list.size()):
		extras_list[i].march_to(location[i])


func deploy_marker() -> Vector2:
	var marker: Marker2D = Marker2D.new();
	marker.global_position = Vector2(2723.0, 3.0);
	level2.add_child(marker);
	return marker.global_position;


func deploy_compass(direction: Vector2) -> Marker2D:
	var compass_instance: Sprite2D = compass_scene.instantiate() as Sprite2D;
	compass_instance.target_position = direction;
	player.add_child(compass_instance);
	return player.get_node("Compass");


func exit() -> void:
	compass_in_world.queue_free();
