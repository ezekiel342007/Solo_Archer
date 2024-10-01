extends CharacterBody2D
class_name Commoner
signal reached_player

@export var state_machine: NodeFiniteStateMachine

var flee: bool = false
var run_to_player: bool = false
var destination: Vector2

func flee_scene() -> void:
	flee = true
	state_machine.transition_to("MoveState")

func run_to(node: Node2D) -> void:
	run_to_player = true
	destination = node.global_position
	state_machine.transition_to("MoveState")
