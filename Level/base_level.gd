extends Node2D
class_name BaseLevel


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.keycode == KEY_ESCAPE:
		$Camera2D.add_child(PauseMenu.new(get_path()))
		get_tree().paused = true
