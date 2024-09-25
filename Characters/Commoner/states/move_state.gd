extends NodeState

@export var character_body_2d: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var speed: int = 2000

@onready var obstacle_sensor_up: RayCast2D = $"../../ObstacleSensors/ObstacleSensorUp"
@onready var obstacle_sensor_left: RayCast2D = $"../../ObstacleSensors/ObstacleSensorLeft"
@onready var obstacle_sensor_down: RayCast2D = $"../../ObstacleSensors/ObstacleSensorDown"
@onready var obstacle_sensor_right: RayCast2D = $"../../ObstacleSensors/ObstacleSensorRight"
@onready var obstacle_sensor_up_left: RayCast2D = $"../../ObstacleSensors/ObstacleSensorUpLeft"
@onready var obstacle_sensor_up_right: RayCast2D = $"../../ObstacleSensors/ObstacleSensorUpRight"
@onready var obstacle_sensor_down_left: RayCast2D = $"../../ObstacleSensors/ObstacleSensorDownLeft"
@onready var obstacle_sensor_down_right: RayCast2D = $"../../ObstacleSensors/ObstacleSensorDownRight"


@onready var commoner = $"../../"

var start_direction: String
var directions: Dictionary

func enter() -> void:
	directions = {
		"up": Vector2.UP,
		"down": Vector2.DOWN,
		"left": Vector2.LEFT,
		"right": Vector2.RIGHT,
		"up_left": Vector2(-0.7, -0.7),
		"up_right": Vector2(0.7, -0.7),
		"down_left": Vector2(-0.7, 0.7),
		"down_right": Vector2(0.7, 0.7)
	}
	animated_sprite_2d.play("move")
	start_direction = directions.keys().pick_random()


func on_physics_process(delta: float) -> void:
	if commoner.flee:
		# Navigate through obstacles
		if obstacle_sensor_up.is_colliding():
			character_body_2d.velocity = Vector2.DOWN
		elif obstacle_sensor_left.is_colliding():
			character_body_2d.velocity = Vector2.RIGHT
		elif obstacle_sensor_down.is_colliding():
			character_body_2d.velocity = Vector2.UP
		elif obstacle_sensor_up_right.is_colliding():
			character_body_2d.velocity = Vector2.LEFT
		elif obstacle_sensor_right.is_colliding():
			character_body_2d.velocity = Vector2.RIGHT
		elif obstacle_sensor_up_right.is_colliding():
			character_body_2d.velocity = Vector2.LEFT
		elif obstacle_sensor_down_left.is_colliding():
			character_body_2d.velocity = Vector2.RIGHT
		elif obstacle_sensor_down_right.is_colliding():
			character_body_2d.velocity = Vector2.LEFT
		else:
			character_body_2d.velocity = directions[start_direction] * speed * delta

	if commoner.run_to_player:
		# Navigate through obstacles
		if obstacle_sensor_up.is_colliding():
			character_body_2d.velocity = Vector2.DOWN
		elif obstacle_sensor_left.is_colliding():
			character_body_2d.velocity = Vector2.RIGHT
		elif obstacle_sensor_down.is_colliding():
			character_body_2d.velocity = Vector2.UP
		elif obstacle_sensor_up_right.is_colliding():
			character_body_2d.velocity = Vector2.LEFT
		elif obstacle_sensor_up_left.is_colliding():
			character_body_2d.velocity = Vector2.RIGHT
		elif obstacle_sensor_up_right.is_colliding():
			character_body_2d.velocity = Vector2.LEFT
		elif obstacle_sensor_down_left.is_colliding():
			character_body_2d.velocity = Vector2.RIGHT
		elif obstacle_sensor_down_right.is_colliding():
			character_body_2d.velocity = Vector2.LEFT
		else:
			if commoner.destination:
				character_body_2d.velocity = commoner.destination - character_body_2d.global_position


	character_body_2d.move_and_slide()

	if abs(commoner.destination - character_body_2d.global_position) <= Vector2(5, 5):
		commoner.reached_player.emit()


func exit() -> void:
	animated_sprite_2d.stop()
