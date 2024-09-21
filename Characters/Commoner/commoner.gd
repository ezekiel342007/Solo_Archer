extends CharacterBody2D
class_name Commoner

@export var state_machine: NodeFiniteStateMachine


func flee() -> void:
	state_machine.transition_to("MoveState")
