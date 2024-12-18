extends CharacterBody2D
class_name Arrow

@export var speed: int = 400
@export var point_at_mouse: bool = true


func _ready() -> void:
	if point_at_mouse:
		rotation = get_angle_to(get_global_mouse_position())
	else:
		rotation_degrees = rotation_degrees


func _physics_process(delta: float) -> void:
	var _collision_info = move_and_collide(velocity.normalized() * delta * speed)


func _on_target_detect_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Obstacle"):
		queue_free()
