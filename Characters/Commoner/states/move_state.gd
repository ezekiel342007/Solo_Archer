extends NodeState

@export var character_body_2d: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var speed: int = 2000

@onready var obstacle_sensor = $"../../ObstacleSensors"
@onready var commoner = $"../../"

var start_direction: String
var directions: Dictionary

func enter() -> void:
	directions = {
		"up": Vector2.UP,
		"down": Vector2.DOWN,
		"left": Vector2.LEFT,
		"right": Vector2.RIGHT,
		"up_left": character_body_2d.global_position.rotated(deg_to_rad(180 + 45)),
		"up_right": character_body_2d.global_position.rotated(deg_to_rad(270 + 45)),
		"down_left": character_body_2d.global_position.rotated(deg_to_rad(90 + 45)),
		"down_right": character_body_2d.global_position.rotated(deg_to_rad(0 + 45))
	}
	animated_sprite_2d.play("move")
	start_direction = directions.keys().pick_random()


func on_physics_process(delta: float) -> void:
	if commoner.flee:
		character_body_2d.velocity = directions[start_direction] * speed * delta

	character_body_2d.move_and_slide()


func exit() -> void:
	animated_sprite_2d.stop()
