extends CharacterBody2D

@onready var sprite = $"Sprite2D"
@export var speed: int = 400


func _ready() -> void:
	sprite.rotation = get_angle_to(get_global_mouse_position())


func _physics_process(delta: float):
	var collision_info = move_and_collide(velocity.normalized() * delta * speed)
