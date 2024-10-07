extends Area2D

var damage: int


func _ready() -> void:
	PlayerManagement.health -= damage


func _physics_process(_delta: float) -> void:
	await get_tree().create_timer(0.5).timeout
	queue_free()
