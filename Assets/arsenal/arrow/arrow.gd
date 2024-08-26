extends CharacterBody2D

@onready var sprite = $"Sprite2D"
@export var speed: int = 400
@export var point_at_mouse: bool = true


func _ready() -> void:
	if point_at_mouse:
		sprite.rotation = get_angle_to(get_global_mouse_position())
	else:
		sprite.rotation_degrees = rotation_degrees

func _physics_process(delta: float) -> void:
	var _collision_info = move_and_collide(velocity.normalized() * delta * speed)


func _on_target_detect_body_entered(_body) -> void:
	queue_free()
