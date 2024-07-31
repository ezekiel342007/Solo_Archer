extends NodeState

@export var character_body_2d: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D

@onready var speed: float = $"../../".speed
@onready var release_point = $"../../ReleasePoint"
@onready var direction: Vector2 = $"../../".direction
@onready var patrol_points: Node = $"../../".patrol_points

var current_point: Vector2
var attack: bool = false
var number_of_points: int
var current_point_position: int
var point_positions: Array[Vector2]


func enter() -> void:
	if patrol_points != null:
		# Assign the number of points
		number_of_points = patrol_points.get_children().size()
		# Populate the point positions list
		for point: Area2D in patrol_points.get_children():
			point_positions.append(point.global_position)
		# Assign the current point
		current_point = point_positions[current_point_position]
	else:
		# Debug error message if are was no patrol points
		print("No patrol points")

	# Flip sprite if neccessary
	flip_sprite()
	animated_sprite_2d.play("move")


func on_physics_process(delta: float) -> void:
	direction = current_point - character_body_2d.position
	character_body_2d.direction = direction

	# Move the goblin in the same direction if it is not near the current point
	if abs(character_body_2d.position - current_point) > Vector2(10.5, 10.5):
		character_body_2d.velocity = direction * speed * delta
	else:
		# If the goblin is near the current point, switch to the next point
		current_point_position += 1

		# To avoid going out of bounds in the point positions list
		if current_point_position >= number_of_points:
			current_point_position = 0

		# Assign the next point as the current point
		current_point = point_positions[current_point_position]
		# Assign the direction
		direction = character_body_2d.position - current_point
		# Flip the sprite if neccessary
		flip_sprite()

	character_body_2d.move_and_slide()


func exit() -> void:
	animated_sprite_2d.stop()


func flip_sprite() -> void:
	# Flip the sprite if the current point is behind the goblin
	if character_body_2d.global_position.x > current_point.x:
		animated_sprite_2d.flip_h = true
		character_body_2d.flip = true
	# Do nothing if the current point is in front of the goblin
	elif character_body_2d.global_position.x < current_point.x:
		animated_sprite_2d.flip_h = false
		character_body_2d.flip = false
