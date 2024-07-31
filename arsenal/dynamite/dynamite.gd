extends CharacterBody2D

var speed: int = 50


func _physics_process(delta: float):
	var collision_info = move_and_collide(velocity.normalized() * delta * speed)
