extends NodeState

@export var character_body_2d: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var damage: int = 5

@onready var explosion: PackedScene = preload("res://Assets/effects/explosion/explosion.tscn")
@onready var tnt_goblin = $"../../"


func enter() -> void:
	animated_sprite_2d.play("detonate")
	print(tnt_goblin.cause_of_death)
	detonate()


func detonate() -> void:
	var explosion_instance: Area2D = explosion.instantiate() as Area2D
	if tnt_goblin.cause_of_death == "Player":
		explosion_instance.damage = 2
	elif tnt_goblin.cause_of_death == "Arrow":
		explosion_instance.damage = 0
	explosion_instance.global_position = character_body_2d.global_position
	character_body_2d.queue_free()
	get_tree().get_root().call_deferred("add_child", explosion_instance)
	# Emit the "has_exploded" signal of the TNTGoblin (grand parent)


func exit() -> void:
	animated_sprite_2d.stop()
