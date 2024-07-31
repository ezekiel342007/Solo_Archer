extends NodeState

@export var character_body_2d: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var attack_speed: float = 1.0

@onready var attack_timer: Timer = $"AttackTimer"
@onready var release_point = $"../../ReleasePoint"
@onready var player_detector: Area2D = %PlayerDetect

var dynamite = preload("res://arsenal/dynamite/dynamite.tscn")
var player_position: float
var dynamite_direction: int


func enter() -> void:
	# Initial throw
	for body in player_detector.get_overlapping_bodies():
		if body.name == "Player":
			player_position = body.position.x

	position_release_point()
	animated_sprite_2d.play("throw")

	throw()

	animated_sprite_2d.play("reload")
	attack_timer.wait_time = attack_speed
	attack_timer.start()


func on_physics_process(_delta):
	# Look through the bodies in the player detector
	for body in player_detector.get_overlapping_bodies():
		# If a body is the player get its position
		if body.name == "Player":
			player_position = body.position.x


func exit() -> void:
	attack_timer.stop()
	animated_sprite_2d.stop()


func throw() -> void:
	var dynamite_instance: CharacterBody2D = dynamite.instantiate() as CharacterBody2D
	dynamite_instance.global_position = release_point.global_position
	dynamite_instance.global_rotation = release_point.global_rotation
	dynamite_instance.velocity.x = dynamite_direction * dynamite_instance.speed
	get_tree().get_root().call_deferred("add_child", dynamite_instance)
	animated_sprite_2d.play("reload")


func position_release_point() -> void:
	# If the player is behind the goblin
	if player_position < character_body_2d.position.x:
		animated_sprite_2d.flip_h = true
		dynamite_direction = -1
		# Flips the position of the release point
		# abs is used to make that we are working with the original value not an edited one
		release_point.position.x = -(abs(release_point.position.x))

	# If the player is in front of the goblin
	elif player_position > character_body_2d.position.x:
		animated_sprite_2d.flip_h = false
		dynamite_direction = 1
		release_point.position.x = abs(release_point.position.x)


func _on_attack_timer_timeout():
	animated_sprite_2d.play("throw")
	position_release_point()
	throw()
	print("Release point position: ", release_point.position.x)
