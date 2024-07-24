class_name NodeFiniteStateMachine
extends Node

@export var initial_node_state: NodeState
var node_states: Dictionary = {}
var current_node_state: NodeState
var current_node_state_name: String


func _ready() -> void:
	# Gets children of state machine which should be node states
	for child in self.get_children():
		# Adds children to node_states dictionary
		if child is NodeState:
			node_states[child.name.to_lower()] = child
			child.transition.connect(transition_to)
	
	# If we were assigned an initial state enter that state and make it the cuurent state
	if initial_node_state:
		initial_node_state.enter()
		current_node_state = initial_node_state
		current_node_state_name = current_node_state.name
	print("State machine initialized")


func _process(delta: float) -> void:
	if current_node_state:
		current_node_state.on_process(delta)

	# print("Current State: ", current_node_state_name)


func _physics_process(delta: float) -> void:
	if current_node_state:
		current_node_state.on_physics_process(delta)


func transition_to(node_state_name: String) -> void:
	# Does nothing if the given state was already running
	if current_node_state_name == node_state_name:
		return
	
	# Else make it the new node state
	var new_node_state: NodeState = node_states.get(node_state_name.to_lower())

	if !new_node_state:
		return

	# Exit the former one
	if current_node_state:
		current_node_state.exit()
	
	# Enter the new one and make it the current
	new_node_state.enter()
	current_node_state = new_node_state
	current_node_state_name = current_node_state.name
