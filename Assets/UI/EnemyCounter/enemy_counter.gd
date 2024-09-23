extends Label
class_name EnemyCounter

var enemy_node_path: String
@onready var enemy_count: int = get_node(enemy_node_path).get_children().size()


func _init(path_to_enemy_node: String) -> void:
	enemy_node_path = path_to_enemy_node


func _ready() -> void:
	enemy_count = get_node(enemy_node_path).get_children().size()
	text = ("Enemy Count: " + str(enemy_count))


func _physics_process(_delta: float) -> void:
	enemy_count = get_node(enemy_node_path).get_children().size()
	text = ("Enemy Count: " + str(enemy_count))
