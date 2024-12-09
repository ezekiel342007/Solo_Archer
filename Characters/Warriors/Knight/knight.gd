extends CharacterBody2D
class_name Knight

@export var state_machine: NodeFiniteStateMachine

signal shot_by_player

var health: int = 10
var destination: Vector2


func march_to(new_position: Vector2) -> void:
	destination = new_position
	state_machine.transition_to("MoveState")


func _physics_process(_delta: float) -> void:
	if abs(destination - global_position) < Vector2(5.0, 5.0):
		state_machine.transition_to("IdleState")

	# if velocity == Vector2(0.0, 0.0):
	# 	state_machine.transition_to("IdleState")


func _on_hurt_box_body_entered(body: Node2D) -> void:
	if body is Arrow:
		shot_by_player.emit()
