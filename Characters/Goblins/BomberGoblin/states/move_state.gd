extends NodeState

@export var character_body_2d: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var wait_time: int = 5
@onready var timer: Timer = $"../../Timer"
@onready var speed: float = $"../../".speed
@onready var patrol_points: Node = $"../../".patrol_points
@onready var direction: Vector2 = $"../../".direction


var current_point: Vector2
var attack: bool = false
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
	animated_sprite_2d.play("move")
	timer.wait_time = wait_time


func on_physics_process(delta: float) -> void:
	direction = current_point - character_body_2d.position

	if abs(character_body_2d.position - current_point) > Vector2(10.5, 10.5):
		character_body_2d.velocity = direction * speed * delta
	else:
		current_point_position += 1

		if current_point_position >= number_of_points:
			current_point_position = 0

		current_point = point_positions[current_point_position]
		direction = character_body_2d.position - current_point

		flip_sprite()
				# Transition to attack
		transition.emit("AttackState")

	# Transitioning states

	# Attack state
	# if attack:
	# 	transition.emit("AttackState")

	character_body_2d.move_and_slide()


func exit() -> void:
	animated_sprite_2d.stop()

func flip_sprite() -> void:
	if character_body_2d.global_position.x > current_point.x:
		animated_sprite_2d.flip_h = true
	elif character_body_2d.global_position.x < current_point.x:
		animated_sprite_2d.flip_h = false


