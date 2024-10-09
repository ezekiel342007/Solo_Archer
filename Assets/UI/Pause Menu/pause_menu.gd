extends Control
class_name PauseMenu

var paused_level_path: NodePath


func _init(level_path: NodePath) -> void:
	paused_level_path = level_path


func _ready() -> void:
	process_mode = PROCESS_MODE_WHEN_PAUSED
	print(paused_level_path)
