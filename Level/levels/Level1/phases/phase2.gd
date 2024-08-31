extends NodeState

@onready var game_screen = %GameScreen
@onready var player = $"../../Player"
@onready var commoner_spawn_position = $"../../CommonerSpawnPosition"
@onready var compass = preload("res://Assets/UI/Compass/compass.tscn")
@onready var surviving_commoner = preload("res://Characters/Commoner/commoner.tscn")
@onready var target_highlighter = preload("res://Assets/UI/TargetHighlighter/target_highlighter.tscn")

var commoner_player_detector: Area2D

func enter() -> void:
	add_survivng_commoner(surviving_commoner)
	# await get_node("../../").child_entered_tree
	highlight_commoner(target_highlighter)
	
	if get_node("../../Commoner"):
		commoner_player_detector = get_node("../../Commoner/PlayerDetectionArea2D") as Area2D
		commoner_player_detector.body_entered.connect(initiate_dialogue)
	commoner_spawn_position.queue_free()
	

func give_direction_to(target: Vector2) -> void:
	var compass_instance: Sprite2D = compass.instantiate() as Sprite2D
	compass_instance.target_position = target
	player.add_child(compass_instance)


func initiate_dialogue(body: Node2D) -> void:
	var highlighter = get_node("../../TargetHighlighter")
	var compass_in_game = get_node("../../Player/Compass")
	if body.name == "Player":
		if highlighter:
			highlighter.queue_free()
		if compass_in_game:
			compass_in_game.queue_free()


func add_survivng_commoner(commoner_scene: PackedScene) -> void:
	var commoner_scene_instance: CharacterBody2D = commoner_scene.instantiate() as CharacterBody2D
	commoner_scene_instance.global_position = commoner_spawn_position.global_position
	give_direction_to(commoner_spawn_position.global_position)
	get_parent().get_parent().add_child(commoner_scene_instance)

func print_node_added(node: Node) -> void:
	print(node, " added")

func highlight_commoner(highlighter: PackedScene) -> void:
	var target_highlighter_instance: Sprite2D = highlighter.instantiate() as Sprite2D
	target_highlighter_instance.target = get_node("../../Commoner")
	get_parent().get_parent().add_child(target_highlighter_instance)

