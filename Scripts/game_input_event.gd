class_name GameInputEvent
extends Node

 
static func horizontal_movement_input() -> float:
	var direction: float = Input.get_axis("move_left", "move_right")
	return direction


static func vertical_movement_input() -> float:
	var direction: float = Input.get_axis("move_backward", "move_forward")
	return direction


static func shoot_intput() -> bool:
	var shoot_input_pressed: bool = Input.is_action_just_pressed("shoot")
	return shoot_input_pressed
