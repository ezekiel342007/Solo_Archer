extends NodeState

@onready var game_screen = %GameScreen
@onready var player = $"../../Player"
@onready var commoner_spawn_position = $"../../CommonerSpawnPosition"
@onready var compass = preload("res://Assets/UI/Compass/compass.tscn")
@onready var surviving_commoner = preload("res://Characters/Commoner/commoner.tscn")
@onready var target_highlighter = preload("res://Assets/UI/TargetHighlighter/target_highlighter.tscn")

var commoner_player_detector: Area2D

func enter() -> void:
	# Prevent the state from repeating
	game_screen.narration_text = ""
	add_survivng_commoner(surviving_commoner)
	highlight_commoner(target_highlighter)
	
	if get_node("../../Commoner"):
		get_node("../../Commoner/PlayerDetectionArea2D").body_entered.connect(initiate_dialogue)
	

func give_direction_to(target: Vector2) -> void:
	var compass_instance: Sprite2D = compass.instantiate() as Sprite2D
	compass_instance.target_position = target
	player.add_child(compass_instance)


func initiate_dialogue(body: Node2D) -> void:
	if body.name == "Player":
		transition.emit("Phase3")


func add_survivng_commoner(commoner_scene: PackedScene) -> void:
	var commoner_scene_instance: CharacterBody2D = commoner_scene.instantiate() as CharacterBody2D
	commoner_scene_instance.global_position = commoner_spawn_position.global_position
	give_direction_to(commoner_spawn_position.global_position)
	get_parent().get_parent().add_child(commoner_scene_instance)


func highlight_commoner(highlighter: PackedScene) -> void:
	var target_highlighter_instance: Sprite2D = highlighter.instantiate() as Sprite2D
	target_highlighter_instance.target = get_node("../../Commoner")
	get_parent().get_parent().add_child(target_highlighter_instance)


func exit() -> void:
	get_node("../../TargetHighlighter").queue_free()
	get_node("../../Player/Compass").queue_free()
	commoner_spawn_position.queue_free()
