extends NodeState

@export var character_body_2d: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@onready var speed: float = $"../../".speed
@onready var release_point = $"../../ReleasePoint"
@onready var patrol_points: Node = $"../../".patrol_points
var dynamite = preload("res://arsenal/dynamite/dynamite.tscn")

var current_point: Vector2
var number_of_points: int
var current_point_position: int
var point_positions: Array[Vector2]

func enter() -> void:
	if patrol_points != null:
		number_of_points = patrol_points.get_children().size()
		for point: Marker2D in patrol_points.get_children():
			point_positions.append(point.global_position)
		current_point = point_positions[current_point_position]
	else:
		print("No patrol points")

	flip_sprite()
	animated_sprite_2d.play("throw")

func on_physics_process(delta: float) -> void:
	throw(delta)

	# Transition to move state
	await get_tree().create_timer(0.9).timeout
	transition.emit("MoveState")


func exit() -> void:
	animated_sprite_2d.flip_h = false
	animated_sprite_2d.stop()


func throw(delta: float) -> void:
	var dynamite_instance: CharacterBody2D = dynamite.instantiate() as CharacterBody2D
	if !dynamite_instance:
		print("Couldn't instantiate node")
	dynamite_instance.global_position = release_point.global_position
	dynamite_instance.velocity = character_body_2d.direction * speed * delta
	get_tree().get_root().add_child(dynamite_instance)
	animated_sprite_2d.play("reload")


func flip_sprite() -> void:
	if character_body_2d.global_position.x > current_point.x:
		animated_sprite_2d.flip_h = true
	elif character_body_2d.global_position.x < current_point.x:
		animated_sprite_2d.flip_h = false


