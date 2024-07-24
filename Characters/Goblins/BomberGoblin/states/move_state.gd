extends NodeState

@export var character_body_2d: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var wait_time: int = 5
@export var speed: float = 0.001
@onready var patrol_points: Node = $"../../".patrol_points
@onready var timer: Timer = $"../../Timer"


var current_point: Vector2
var number_of_points: int
var current_point_position: int
var point_positions: Array[Vector2]
var direction: Vector2


func enter() -> void:
	animated_sprite_2d.play("move")

	if patrol_points != null:
		number_of_points = patrol_points.get_children().size()
		for point: Marker2D in patrol_points.get_children():
			point_positions.append(point.global_position)
		current_point = point_positions[current_point_position]
	else:
		print("No patrol points")

	timer.wait_time = wait_time


func on_physics_process(delta: float) -> void:
	direction = current_point - character_body_2d.position
	if abs(character_body_2d.position - current_point) > Vector2(4.5, 4.5):
		character_body_2d.velocity = direction * speed * delta
		print("Goblin position: ", character_body_2d.position)
		print("Current point position: ", current_point)
		# print("Goblin position: ", character_body_2d.position)
	else:
		current_point_position += 1

		if current_point_position >= number_of_points:
			current_point_position = 0

		current_point = point_positions[current_point_position]

		direction = character_body_2d.position - current_point

	character_body_2d.move_and_slide()


func exit() -> void:
	animated_sprite_2d.stop()
