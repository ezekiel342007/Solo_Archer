extends CharacterBody2D
class_name Player

@export var health: int = 100
@export var enemy_node: Node

var can_move: bool = true


func _ready():
	for enemy in enemy_node.get_children():
		if enemy.name == "TNTGoblin":
			enemy.has_exploded.connect(on_has_exploded)
	

func on_has_exploded(damage: int) -> void:
	PlayerManagement.health -= damage
