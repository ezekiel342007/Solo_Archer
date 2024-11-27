extends Label
class_name EnemyCounter

var enemies_node: Node
signal cleared_enemy

@onready var enemy_count: int = enemies_node.get_children().size()

func _init(enemy_node: Node, cleared_enemy_function: Callable):
	enemies_node = enemy_node
	cleared_enemy.connect(cleared_enemy_function)


func _ready() -> void:
	enemy_count = enemies_node.get_children().size()
	text = ("Enemy Count: " + str(enemy_count))


func _physics_process(_delta: float) -> void:
	enemy_count = enemies_node.get_children().size()
	if enemy_count == 0: cleared_enemy.emit()
	text = ("Enemy Count: " + str(enemy_count))
