extends Node

var health: int = 10
var quiver: int = 100

signal has_died

func _physics_process(_delta: float) -> void:
	if health <= 0:
		health = 10
		has_died.emit()
