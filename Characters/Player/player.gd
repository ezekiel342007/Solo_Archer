extends CharacterBody2D

@export var health: int = 100


func explode(damage: int) -> void:
	health -= damage
	print("explosion")
