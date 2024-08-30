extends Sprite2D

@export var target_node: Node2D

var target_position: Vector2

func _ready() -> void:
	target_position = target_node.global_position

func _physics_process(_delta: float) -> void:
	point_at(target_node.global_position)


func point_at(target: Vector2) -> void:
	var distance = global_position - target
	rotation = transform.x.angle_to_point(distance) + to_radians(-68)


func to_radians(angle: int) -> float:
	return angle * (1/(180 / PI))
