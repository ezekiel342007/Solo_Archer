class_name GameInputEvent
extends Node

static var action_keys: Dictionary = {
	"Enter or Space": &"ui_accept",
	"": &"ui_accept",
	"S": &"move_left",
	"F": &"move_right",
	"E": &"move_forward",
	"D": &"move_backward",
}

 
static func horizontal_movement_input() -> float:
	var direction: float = Input.get_axis("move_left", "move_right")
	return direction


static func vertical_movement_input() -> float:
	var direction: float = Input.get_axis("move_forward", "move_backward")
	return direction


static func shoot_input() -> bool:
	var shoot_input_pressed: bool = Input.is_action_just_pressed("shoot")
	return shoot_input_pressed


static func shoot_right_input() -> bool:
	var shoot_right_input_pressed: bool = Input.is_action_just_pressed("shoot_right")
	return shoot_right_input_pressed


static func shoot_left_input() -> bool:
	var shoot_left_input_pressed: bool = Input.is_action_just_pressed("shoot_left")
	return shoot_left_input_pressed


static func shoot_up_input() -> bool:
	var shoot_up_input_pressed: bool = Input.is_action_just_pressed("shoot_up")
	return shoot_up_input_pressed


static func shoot_down_input() -> bool:
	var shoot_down_input_pressed: bool = Input.is_action_just_pressed("shoot_down")
	return shoot_down_input_pressed


static func shoot_diagonal_up_right_input() -> bool:
	var shoot_diagonal_up_right_pressed: bool = Input.is_action_pressed("shoot_up") and Input.is_action_just_pressed("shoot_right")
	return shoot_diagonal_up_right_pressed


static func shoot_diagonal_up_left_input() -> bool:
	var shoot_diagonal_up_left_pressed: bool = Input.is_action_pressed("shoot_up") and Input.is_action_just_pressed("shoot_left")
	return shoot_diagonal_up_left_pressed


static func shoot_diagonal_down_left_input() -> bool:
	var shoot_diagonal_down_left_pressed: bool = Input.is_action_pressed("shoot_down") and Input.is_action_just_pressed("shoot_left")
	return shoot_diagonal_down_left_pressed


static func shoot_diagonal_down_right_input() -> bool:
	var shoot_diagonal_down_right_pressed: bool = Input.is_action_pressed("shoot_down") and Input.is_action_just_pressed("shoot_right")
	return shoot_diagonal_down_right_pressed
