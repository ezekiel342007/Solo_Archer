extends CharacterBody2D

@onready var sprite = $"Sprite2D"
@export var speed: int = 400


func _ready() -> void:
	# Make the arrow face the direction its being shot at
	sprite.rotation = get_angle_to(get_global_mouse_position())
