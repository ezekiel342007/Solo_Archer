extends NodeState

@export var character_body_2d: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var speed: int = 70

@onready var commoner = $"../../"

@onready var obstacle_sensor_node: Node = $"../../ObstacleSensors"
@onready var obstacle_sensor_up: RayCast2D = $"../../ObstacleSensors/ObstacleSensorUp"
@onready var obstacle_sensor_left: RayCast2D = $"../../ObstacleSensors/ObstacleSensorLeft"
@onready var obstacle_sensor_down: RayCast2D = $"../../ObstacleSensors/ObstacleSensorDown"
@onready var obstacle_sensor_right: RayCast2D = $"../../ObstacleSensors/ObstacleSensorRight"
@onready var obstacle_sensor_up_left: RayCast2D = $"../../ObstacleSensors/ObstacleSensorUpLeft"
@onready var obstacle_sensor_up_right: RayCast2D = $"../../ObstacleSensors/ObstacleSensorUpRight"
@onready var obstacle_sensor_down_left: RayCast2D = $"../../ObstacleSensors/ObstacleSensorDownLeft"
@onready var obstacle_sensor_down_right: RayCast2D = $"../../ObstacleSensors/ObstacleSensorDownRight"

var directions: Dictionary
var start_direction: String


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
	for obstacle_sensor: RayCast2D in obstacle_sensor_node.get_children():
		obstacle_sensor.add_exception(character_body_2d)


func on_physics_process(delta: float) -> void:
	if commoner.flee:
		character_body_2d.velocity = directions[start_direction] * speed * delta
		# Navigate through obstacles
		# if obstacle_sensor_up.is_colliding():
		# 	character_body_2d.velocity = Vector2.DOWN * speed * delta
		# if obstacle_sensor_left.is_colliding():
		# 	character_body_2d.velocity = Vector2.UP * speed * delta
		# if obstacle_sensor_down.is_colliding():
		# 	character_body_2d.velocity = Vector2.RIGHT * speed * delta
		# if obstacle_sensor_up_right.is_colliding():
		# 	character_body_2d.velocity = Vector2.DOWN * speed * delta
		# if obstacle_sensor_right.is_colliding():
		# 	character_body_2d.velocity = Vector2.DOWN * speed * delta
		# 	# print(str(obstacle_sensor_up.get_collider()))
		# if obstacle_sensor_up_right.is_colliding():
		# 	character_body_2d.velocity = Vector2.LEFT * speed * delta
		# if obstacle_sensor_down_left.is_colliding():
		# 	character_body_2d.velocity = Vector2.RIGHT * speed * delta
		# if obstacle_sensor_down_right.is_colliding():
		# 	character_body_2d.velocity = Vector2.RIGHT * speed * delta
		
		character_body_2d.velocity = directions[start_direction] * speed * delta

	if commoner.run_to_player:
		# Navigate through obstacles
		# if obstacle_sensor_up.is_colliding():
		# 	character_body_2d.velocity = Vector2.DOWN * speed * delta
		# elif obstacle_sensor_left.is_colliding():
		# 	character_body_2d.velocity = Vector2.RIGHT * speed * delta
		# elif obstacle_sensor_down.is_colliding():
		# 	character_body_2d.velocity = Vector2.UP * speed * delta
		# elif obstacle_sensor_up_right.is_colliding():
		# 	character_body_2d.velocity = Vector2.LEFT * speed * delta
		# elif obstacle_sensor_up_left.is_colliding():
		# 	character_body_2d.velocity = Vector2.RIGHT * speed * delta
		# elif obstacle_sensor_up_right.is_colliding():
		# 	character_body_2d.velocity = Vector2.LEFT * speed * delta
		# elif obstacle_sensor_down_left.is_colliding():
		# 	character_body_2d.velocity = Vector2.RIGHT * speed * delta
		# elif obstacle_sensor_down_right.is_colliding():
		# 	character_body_2d.velocity = Vector2.LEFT * speed * delta
		#
		if commoner.destination:
			character_body_2d.velocity = (commoner.destination.global_position - character_body_2d.global_position) * speed * delta

	character_body_2d.move_and_slide()


func exit() -> void:
	animated_sprite_2d.stop()
