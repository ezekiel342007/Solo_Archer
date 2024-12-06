extends NodeState

@onready var player: Player = %Player
@onready var level2: BaseLevel = $"../.."
@onready var extras: Node = $"../../Extras"
@onready var camera: GameCamera = %Camera2D
@onready var game_screen: CanvasLayer = %GameScreen
@onready var meeting_point: Marker2D = $"../../MeetingPoint"
@onready var meeting_point_area: Area2D = $"../../MeetingPoint/Area2D"
@onready var compass_scene: PackedScene = preload("res://Assets/UI/Compass/compass.tscn")

var compass_in_world: Marker2D


func enter() -> void:
	meeting_point_area.body_entered.connect(
		func (node: Node2D): 
			game_screen.margin_container.add_child(level2.deploy_narration_banner(
				null,
				{&"have_shown_message": func (): meeting_point.queue_free()},
				Message.make_script(
					level2.phase_1_player_with_commander,
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
	compass_in_world = deploy_compass()


func on_physics_process(_delta: float) -> void:
	if camera.get_viewport_rect().has_point(meeting_point.global_position):
		transition.emit("Phase2")


func deploy_compass() -> Marker2D:
	var compass_instance: Sprite2D = compass_scene.instantiate() as Sprite2D
	compass_instance.target_position = meeting_point.global_position
	player.add_child(compass_instance)
	return player.get_node("Compass")


func exit() -> void:
	compass_in_world.queue_free()
	meeting_point.queue_free()
	queue_free()
