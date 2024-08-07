extends NodeState

@export var character_body_2d: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var attack_speed: float = 1.0

@onready var attack_timer: Timer = $"AttackTimer"
@onready var release_point = $"../../ReleasePoint"
@onready var player_detector: Area2D = %PlayerDetect

var explosion = preload("res://Assets/effects/explosion/explosion.tscn")
var player_position: Vector2


func enter() -> void:
	# Initial throw
	animated_sprite_2d.play("throw")
	for body in player_detector.get_overlapping_bodies():
		if body.name == "Player":
			player_position = body.position

	position_release_point()

	await animated_sprite_2d.animation_finished
	explode()

	attack_timer.wait_time = attack_speed
	attack_timer.start()


func on_physics_process(_delta):
	# Look through the bodies in the player detector
	for body in player_detector.get_overlapping_bodies():
		# If a body is the player get its position
		if body.name == "Player":
			player_position = body.position


func exit() -> void:
	attack_timer.stop()
	animated_sprite_2d.stop()


func explode() -> void:
	var explosion_instance: Area2D = explosion.instantiate() as Area2D
	explosion_instance.global_position = release_point.global_position
	get_tree().get_root().add_child(explosion_instance)


func position_release_point() -> void:

	# If the player is behind the goblin
	if player_position.x < character_body_2d.position.x:
		# Flips the goblin
		animated_sprite_2d.flip_h = true
		# Always target the player
		release_point.global_position = player_position

	# If the player is in front of the goblin
	elif player_position.x > character_body_2d.position.x:
		animated_sprite_2d.flip_h = false

		# Always target the player
		release_point.global_position = player_position


func _on_attack_timer_timeout():
	animated_sprite_2d.play("throw")
	position_release_point()
	await animated_sprite_2d.animation_finished
	explode()
