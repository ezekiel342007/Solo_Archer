extends NodeState

@export var character_body_2d: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var speed: int = 15000



func enter() -> void:
	animated_sprite_2d.play("move")


func on_physics_process(delta: float) -> void:
	var direction_x: float = GameInputEvent.horizontal_movement_input()
	var direction_y: float = GameInputEvent.vertical_movement_input()

	if direction_x or direction_y:
		character_body_2d.velocity.x = direction_x * speed * delta
		character_body_2d.velocity.y = direction_y * speed * delta

	character_body_2d.move_and_slide()

	# Transitioning states

	# Idle state
	if direction_x == 0 and direction_y == 0:
		transition.emit("IdleState")


func exit() -> void:
	animated_sprite_2d.stop()
