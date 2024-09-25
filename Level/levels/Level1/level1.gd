extends Node2D
var start_spawn: bool = false

var phase1: bool = false
var phase2: bool = false
var phase3: bool = false
var phase4: bool = false


func _ready() -> void:
	PlayerManagement.has_died.connect(restart)


func restart() -> void:
	get_tree().reload_current_scene()
