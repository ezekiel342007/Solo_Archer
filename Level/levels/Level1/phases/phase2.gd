extends NodeState

@onready var game_screen = %GameScreen
@onready var player = $"../../Player"
@onready var commoner_spawn_position = $"../../CommonerSpawnPosition"
@onready var compass = preload("res://Assets/UI/Compass/compass.tscn")
@onready var surviving_commoner = preload("res://Characters/Commoner/commoner.tscn")


func enter():
	print("Phase 2 initialized")
	var surviving_commoner_instance: CharacterBody2D = surviving_commoner.instantiate() as CharacterBody2D
	surviving_commoner_instance.global_position = commoner_spawn_position.global_position
	give_direction_to(commoner_spawn_position.global_position)
	commoner_spawn_position.queue_free()
	get_tree().get_root().add_child(surviving_commoner_instance)


func give_direction_to(target: Vector2) -> void:
	var compass_instance: Sprite2D = compass.instantiate() as Sprite2D
	compass_instance.target_position = target
	player.add_child(compass_instance)
