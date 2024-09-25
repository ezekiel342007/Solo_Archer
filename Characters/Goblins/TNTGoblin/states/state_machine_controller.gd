extends Node

@export var state_machine: NodeFiniteStateMachine

@onready var tnt_goblin = $"../"



func _on_detonation_region_body_entered(body):
	if body.name == "Player":
		tnt_goblin.cause_of_death = "Player"
		state_machine.transition_to("DetonateState")
	if  body.name == "Arrow":
		tnt_goblin.cause_of_death = "Arrow"
		state_machine.transition_to("DetonateState")
