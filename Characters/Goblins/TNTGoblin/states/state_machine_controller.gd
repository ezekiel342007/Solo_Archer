extends Node

@export var state_machine: NodeFiniteStateMachine


func _on_detonation_region_body_entered(body):
	if body.name == "Player" or body.name == "Arrow":
		state_machine.transition_to("DetonateState")
