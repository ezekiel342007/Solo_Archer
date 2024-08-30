extends NodeState

@onready var surviving_commoner = preload("res://Characters/Commoner/commoner.tscn")
@onready var commoner_spawn_position = $"../../CommonerSpawnPosition"

func enter():
	print("Phase 2 initialized")
	var surviving_commoner_instance: CharacterBody2D = surviving_commoner.instantiate() as CharacterBody2D
	surviving_commoner_instance.global_position = commoner_spawn_position.global_position
	commoner_spawn_position.queue_free()
	get_tree().get_root().add_child(surviving_commoner_instance)
