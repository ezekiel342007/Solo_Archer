extends NodeState

@export var character_body_2d: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var damage: int = 5
@onready var explosion: PackedScene = preload("res://Assets/effects/explosion/explosion.tscn")



func enter() -> void:
	animated_sprite_2d.play("detonate")
	detonate()


func exit() -> void:
	animated_sprite_2d.stop()


func detonate() -> void:
	var explosion_instance: Area2D = explosion.instantiate() as Area2D
	explosion_instance.global_position = character_body_2d.global_position
	character_body_2d.queue_free()
	get_tree().get_root().call_deferred("add_child", explosion_instance)
	# Emit the "has_exploded" signal of the TNTGoblin (grand parent)
	get_parent().get_parent().has_exploded.emit(damage)
