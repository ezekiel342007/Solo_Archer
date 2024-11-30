extends CharacterBody2D
class_name Commoner

@export var state_machine: NodeFiniteStateMachine

@onready var player_detector: Area2D = $PlayerDetectionArea2D

func _ready() -> void:
	unique_name_in_owner = true

var flee: bool = false
var run_to_player: bool = false
var destination: Node2D

func flee_scene() -> void:
	flee = true
	run_to_player = false
	state_machine.transition_to("MoveState")

func run_to(node: Node2D) -> void:
	run_to_player = true
	flee = false
	destination = node
	state_machine.transition_to("MoveState")
