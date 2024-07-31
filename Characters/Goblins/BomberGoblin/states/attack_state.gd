extends NodeState

@export var character_body_2d: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var attack_speed: float = 1.0

@onready var release_point = $"../../ReleasePoint"
@onready var attack_timer: Timer = $"AttackTimer"

var dynamite = preload("res://arsenal/dynamite/dynamite.tscn")


func enter() -> void:
	animated_sprite_2d.play("throw")
	throw()
	animated_sprite_2d.play("reload")
	attack_timer.wait_time = attack_speed
	attack_timer.start()


func on_physics_process(_delta):
	print("In attack state")

func exit() -> void:
	attack_timer.stop()
	animated_sprite_2d.stop()


func throw() -> void:
	var dynamite_instance: CharacterBody2D = dynamite.instantiate() as CharacterBody2D
	dynamite_instance.global_position = release_point.global_position
	dynamite_instance.global_rotation = release_point.global_rotation
	dynamite_instance.velocity.x = character_body_2d.direction.rotated(character_body_2d.rotation).x * dynamite_instance.speed
	get_tree().get_root().add_child(dynamite_instance)
	animated_sprite_2d.play("reload")


func position_release_point() -> void:
	if character_body_2d.flip:
		release_point.global_position.x -= 80.0
	else:
		release_point.global_position.x += 40.0


func _on_attack_timer_timeout():
	animated_sprite_2d.play("throw")
	throw()
