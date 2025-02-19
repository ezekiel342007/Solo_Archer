extends Node

var battle: bool = false
@export var state_machine: NodeFiniteStateMachine

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if get_children().size() == 0 and battle:
		state_machine.transition_to("Phase4");
