extends CharacterBody2D
class_name Knight

@export var state_machine: NodeFiniteStateMachine

var health: int = 10
var destination: Vector2


func march_to(new_position: Vector2) -> void:
	destination = new_position
	state_machine.transition_to("MoveState")
	print(name, " position: ", global_position)
	print(name, " destination: ", new_position)
	print(name, " distance: ", new_position - global_position)


func _physics_process(_delta: float) -> void:
	if abs(destination - global_position) < (Vector2(5, 5)):
		state_machine.transition_to("IdleState")


func _on_destination_finder_body_entered(_body: Node2D) -> void:
	state_machine.transition_to("IdleState")
