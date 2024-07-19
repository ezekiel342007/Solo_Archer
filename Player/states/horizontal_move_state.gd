extends NodeState

@export var character_body_2d: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var speed: int = 300


func enter() -> void:
	animated_sprite_2d.play("move")


func on_physics_process(_delta: float) -> void:
	var direction: float = GameInputEvent.horizontal_movement_input()

	if direction:
		character_body_2d.velocity.x = direction * speed

	character_body_2d.move_and_slide()

	# Transitioning states

	# Idle state
	if direction == 0:
		transition.emit("IdleState")

	# Vertical movement state
	if GameInputEvent.vertical_movement_input():
		transition.emit("VerticalMovementInput")


func exit() -> void:
	animated_sprite_2d.stop()
