extends NodeState

@onready var player: Player = %Player
@onready var camera: GameCamera = %Camera2D
@onready var meeting_point: Marker2D = $"../../MeetingPoint"
@onready var compass_scene: PackedScene = preload("res://Assets/UI/Compass/compass.tscn")

var compass_in_world: Marker2D


func enter() -> void:
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
