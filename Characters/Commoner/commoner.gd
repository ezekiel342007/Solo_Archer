extends CharacterBody2D
class_name Commoner

@export var state_machine: NodeFiniteStateMachine

@onready var player_detector: Area2D = $PlayerDetectionArea2D

func _ready() -> void:
	unique_name_in_owner = true

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
