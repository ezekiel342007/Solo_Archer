extends Label
class_name EnemyCounter

var enemies_node: Node

@onready var enemy_count: int = enemies_node.get_children().size()


func _init(enemy_node: Node): 
	enemies_node = enemy_node


func _ready() -> void:
	enemy_count = enemies_node.get_children().size()
	text = ("Enemy Count: " + str(enemy_count))


func _physics_process(_delta: float) -> void:
	enemy_count = enemies_node.get_children().size()
	text = ("Enemy Count: " + str(enemy_count))
