extends NodeState

@export var character_body_2d: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D


func enter() -> void:
	animated_sprite_2d.play("idle")


func on_process(_delta: float) -> void:
	pass


func on_physics_process(_delta: float) -> void:
	# Transitioning states

	# Horizontal move state
	if GameInputEvent.horizontal_movement_input() or GameInputEvent.vertical_movement_input():
		transition.emit("MoveState")

	


func exit() -> void:
	animated_sprite_2d.stop()
