extends Area2D

@export var speed: int = 500
@export var arrow_range: int = 1500

var travelled_distance: int = 0


func _physics_process(delta: float):
	position.x += speed * delta
	travelled_distance += int(speed * delta)
	
	if travelled_distance > arrow_range:
		queue_free()
	


func _on_body_entered(_body):
	queue_free()
