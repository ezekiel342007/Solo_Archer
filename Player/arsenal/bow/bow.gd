extends Area2D

@onready var mallee_area_2d = $MalleeArea2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var release_marker_2d = $AnimatedSprite2D/ReleaseMarker2D
var arrow = preload("res://Player/arsenal/arrow/arrow.tscn")

func _ready() -> void:
	animated_sprite_2d.play("aim")


func _physics_process(_delta: float) -> void:
	rotate_to_target(get_global_mouse_position(), _delta)

	if GameInputEvent.shoot_intput():
		shoot()
		animated_sprite_2d.play("aim")



func rotate_to_target(target: Vector2, _delta: float):
	var target_direction: Vector2 = target - global_position 
	var aim = transform.x.angle_to_point(target_direction)
	rotation = aim


func shoot():
	var arrow_instance: CharacterBody2D = arrow.instantiate() as CharacterBody2D
	arrow_instance.global_position = release_marker_2d.global_position
	arrow_instance.velocity = (get_global_mouse_position() - arrow_instance.position) * arrow_instance.speed
	animated_sprite_2d.play("shoot")
	get_tree().get_root().add_child(arrow_instance)
