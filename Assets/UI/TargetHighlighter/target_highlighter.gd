extends Sprite2D
var target: Node2D

func _ready() -> void:
	global_position = target.global_position


func _physics_process(_delta: float) -> void:
	global_position = target.global_position
