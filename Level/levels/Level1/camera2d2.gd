extends Camera2D

@export_category("Focus on")
@export var focus: CharacterBody2D
@export_category("Transitioning")
@export var transition_speed: float = 3.0

var transitioning: bool = false
var transition_target: Vector2


func _physics_process(_delta: float) -> void:
	if focus:
		if transitioning == false:
			global_position = focus.global_position
		else:
			global_position = transition_target
			zoom = Vector2(1.7, 1.7)
			get_tree().create_tween().tween_property(self, "zoom", Vector2(1.0, 1.0), 2.5)
			get_tree().create_tween().tween_property(self, "global_position", focus.global_position, 2.5)

		if global_position == focus.global_position:
			transitioning = false


func transition_from(target: Vector2) -> void:
	transitioning = !transitioning
	transition_target = target
