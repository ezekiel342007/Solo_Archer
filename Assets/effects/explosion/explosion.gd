extends Area2D

var damage: int


func _ready() -> void:
	PlayerManagement.health -= damage


func _physics_process(_delta: float) -> void:
	# Get bodies that are within range
	for body in get_overlapping_bodies():
		# If the body is explodable make it explode
		if body.is_in_group("explodable"):
			body.explode()

	await get_tree().create_timer(0.5).timeout
	queue_free()
