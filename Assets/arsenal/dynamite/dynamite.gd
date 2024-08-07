extends CharacterBody2D

@export var max_distance: int = 300

@onready var explosion = preload("res://Assets/effects/explosion/explosion.tscn")

var speed: int = 50


func _physics_process(delta: float):
	var _collision_info = move_and_collide(velocity.normalized() * delta * speed)


func detonate() -> void:
	var explosion_instance: AnimatedSprite2D = explosion.instantiate() as AnimatedSprite2D
	explosion_instance.global_position = global_position
	get_tree().get_root().call_deferred("add_child", explosion_instance)
	queue_free()


func _on_trigger_body_entered(body):
	detonate()
