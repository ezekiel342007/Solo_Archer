extends Area2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var release_marker_2d = $AnimatedSprite2D/ReleaseMarker2D

var arrow = preload("res://Assets/arsenal/arrow/arrow.tscn")
var mouse_control: bool = true
var target_direction: Vector2
var stp_time: int
var stt_time: int
var key_delay: int = 2000
var combo: bool = false


func _ready() -> void:
	animated_sprite_2d.play("aim")


func _physics_process(_delta: float) -> void:
	if GameInputEvent.shoot_up_input():
		stt_time = Time.get_ticks_msec()
		# Handles a diagonal up right shots
		if GameInputEvent.shoot_right_input():
			stp_time = Time.get_ticks_msec()
			if stt_time - stp_time <= key_delay:
				combo = true
				shoot_with_key("diagonal_up_right")
			else:
				combo = false
		# Handles a diagonal up left shots
		elif GameInputEvent.shoot_left_input():
			stp_time = Time.get_ticks_msec()
			if stt_time - stp_time <= key_delay:
				combo = true
				shoot_with_key("diagonal_up_left")
			else:
				combo = false
		else:
			shoot_with_key("up")
		mouse_control = false
		animated_sprite_2d.play("aim")

	if GameInputEvent.shoot_down_input():
		stt_time = Time.get_ticks_msec()
		# Handles diagonal down right shots
		if GameInputEvent.shoot_right_input():
			stp_time = Time.get_ticks_msec()
			if stt_time - stp_time <= key_delay:
				combo = true
				shoot_with_key("diagonal_down_right")
			else:
				combo = false
		# Handles diagonal down left shots
		elif GameInputEvent.shoot_left_input():
			stp_time = Time.get_ticks_msec()
			if stt_time - stp_time <= key_delay:
				combo = true
				shoot_with_key("diagonal_down_left")
			else:
				combo = false
		else:
			shoot_with_key("down")
		mouse_control = false
		animated_sprite_2d.play("aim")

	# To handle a single right shot, distinguishing it from a combo shot
	if GameInputEvent.shoot_right_input() and !combo:
		mouse_control = false
		shoot_with_key("right")
		animated_sprite_2d.play("aim")
	elif GameInputEvent.shoot_right_input() and combo:
		combo = false

	if GameInputEvent.shoot_left_input() and !combo:
		mouse_control = false
		shoot_with_key("left")
		animated_sprite_2d.play("aim")
	elif GameInputEvent.shoot_left_input() and combo:
		combo = false

	if mouse_control:
		rotate_to_target(get_global_mouse_position(), _delta)

	if GameInputEvent.shoot_input():
		shoot()
		animated_sprite_2d.play("aim")
	

func _input(event):
	if event is InputEventMouseMotion:
		mouse_control = true


func rotate_to_target(target: Vector2, _delta: float) -> void:
	target_direction = target - global_position 
	var aim = transform.x.angle_to_point(target_direction)
	rotation = aim


func shoot() -> void:
	var arrow_instance: CharacterBody2D = arrow.instantiate() as CharacterBody2D
	arrow_instance.global_position = release_marker_2d.global_position
	arrow_instance.velocity = target_direction.normalized() * arrow_instance.speed
	animated_sprite_2d.play("shoot")
	get_tree().get_root().add_child(arrow_instance)


func shoot_with_key(key: String) -> void:
	var arrow_instance: CharacterBody2D = arrow.instantiate() as CharacterBody2D
	# Implement arrow shot based on which key was pressed
	match key:
		"right":
			if !combo:
				rotation_degrees = 0
				arrow_instance.velocity.x = arrow_instance.speed
		"left":
			if !combo:
				rotation_degrees = 180
				arrow_instance.velocity.x = -arrow_instance.speed
				arrow_instance.rotation_degrees = (rotation_degrees)
		"up":
			rotation_degrees = -90
			arrow_instance.velocity.y = -arrow_instance.speed
			arrow_instance.rotation_degrees = (rotation_degrees)
		"down":
			rotation_degrees = 90
			arrow_instance.velocity.y = arrow_instance.speed
			arrow_instance.rotation_degrees = (rotation_degrees)
		"diagonal_up_right":
			rotation_degrees = -45
			arrow_instance.velocity = release_marker_2d.position.rotated(to_radians(343)) * arrow_instance.speed
			arrow_instance.rotation_degrees = (rotation_degrees)
		"diagonal_up_left":
			rotation_degrees = -135
			arrow_instance.velocity = release_marker_2d.position.rotated(to_radians(253)) * arrow_instance.speed
			arrow_instance.rotation_degrees = (rotation_degrees)
		"diagonal_down_left":
			rotation_degrees = 135
			arrow_instance.velocity = release_marker_2d.position.rotated(to_radians(163)) * arrow_instance.speed
			arrow_instance.rotation_degrees = (rotation_degrees)
		"diagonal_down_right":
			rotation_degrees = 45
			arrow_instance.velocity = release_marker_2d.position.rotated(to_radians(73)) * arrow_instance.speed
			arrow_instance.rotation_degrees = (rotation_degrees)
	
	arrow_instance.global_position = release_marker_2d.global_position
	# Make sure the arrows don't face the mouse but the correct direction
	arrow_instance.point_at_mouse = false
	animated_sprite_2d.play("shoot")
	get_tree().get_root().add_child(arrow_instance)


func to_radians(angle: int) -> float:
	return angle * (1/(180 / PI))
