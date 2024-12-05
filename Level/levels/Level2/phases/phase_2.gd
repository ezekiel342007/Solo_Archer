extends NodeState

@onready var level2 = $"../.."


func enter() -> void:
	level2.deploy_narration_banner()
