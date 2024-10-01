extends Node


var health: int = 10
var quiver: int = 100

signal has_died


func _physics_process(_delta: float) -> void:
	if health <= 0:
		has_died.emit()
		health = 10
