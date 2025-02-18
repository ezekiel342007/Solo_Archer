extends NodeState;

@export var character_body_2d: CharacterBody2D;
@export var animated_sprite_2d: AnimatedSprite2D;
@export var attack_speed: float = 1.0;

@onready var attack_timer: Timer = $"AttackTimer";
@onready var release_point = $"../../ReleasePoint";
@onready var player_detector: Area2D = %PlayerDetect;

var targeted_body: CharacterBody2D;
var dynamite_direction: float = 1.0;
var dynamite: Resource = preload("res://Assets/arsenal/dynamite/dynamite.tscn")

func enter() -> void:
	# Initial throw
	animated_sprite_2d.play("throw")
	for body in player_detector.get_overlapping_bodies():
		if body.name == "Player":
			targeted_body = body;

	position_release_point();

	attack_timer.wait_time = attack_speed;
	await animated_sprite_2d.animation_finished;
	throw_at(targeted_body);

	attack_timer.start();


func on_physics_process(_delta):
	# Look through the bodies in the player detector
	for body in player_detector.get_overlapping_bodies():
		# If a body is the player get its position
		if body.name == "Player":
			targeted_body = body;

		if body.global_position.x < character_body_2d.global_position.x:
			dynamite_direction = 1.0;
		else:
			dynamite_direction = -1.0;


func throw_at(target: CharacterBody2D) -> void:
	var dynamite_instance = dynamite.instantiate();
	dynamite_instance.global_position = release_point.global_position;
	dynamite_instance.direction = dynamite_direction;
	dynamite_instance.target = target;
	get_tree().get_root().add_child(dynamite_instance);


func position_release_point() -> void:
	# If the player is behind the goblin
	if targeted_body.global_position.x < character_body_2d.global_position.x:
		# Flips the goblin
		animated_sprite_2d.flip_h = true;
		# Always target the player
		release_point.position = -release_point.position;
	# If the player is in front of the goblin
	elif targeted_body.global_position.x > character_body_2d.global_position.x:
		animated_sprite_2d.flip_h = false;
		# Always target the player
		release_point.position = release_point.position;


func _on_attack_timer_timeout():
	animated_sprite_2d.play("throw");
	position_release_point();
	await animated_sprite_2d.animation_finished;
	throw_at(targeted_body);


func exit() -> void:
	attack_timer.stop()
	animated_sprite_2d.stop()
