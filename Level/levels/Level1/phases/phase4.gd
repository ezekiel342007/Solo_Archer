extends NodeState
@onready var player: CharacterBody2D = %Player
@onready var surviving_commoner: CharacterBody2D = $"../../Commoner"

var ending_conversation: bool = false
var ending_conversation_lines: Array[Dictionary] = [
	{
		"Speaker": "Player",
		"Message": "Let's leave",
	},
	{
		"Speaker": "Player",
		"Message": "Let's leave",
	},
	{
		"Speaker": "Player",
		"Message": "Let's leave",
	},
	{
		"Speaker": "Player",
		"Message": "Let's leave",
	}
]



func enter() -> void:
	print("Phase4 initiated")
	


func _on_level_1_child_exiting_tree(node):
	if node.name == "Goblin":
		ending_conversation = true


func move_surviving_commoner_to_player() -> void:
	surviving_commoner.velocity = (player.global_position - surviving_commoner.global_position)
