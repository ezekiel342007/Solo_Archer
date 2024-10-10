extends Node2D
class_name BaseLevel

@onready var player: CharacterBody2D = %Player
@onready var game_screen = %Camera2D.get_node("GameScreen")
@onready var pause_menu = preload("res://Assets/UI/Pause Menu/pause_menu.tscn")


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.keycode == KEY_ESCAPE:
		game_screen.margin_container.add_child(deploy_pause_menu_instance())
		get_tree().paused = true


func deploy_pause_menu_instance() -> ColorRect:
	var pause_menu_instance: ColorRect = pause_menu.instantiate() as ColorRect
	pause_menu_instance.paused_level_path = scene_file_path
	return pause_menu_instance
