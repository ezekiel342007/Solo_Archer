extends ColorRect
class_name RestarMenu

var failed_level: String


func _on_quit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Assets/UI/Main Menu/main_menu.tscn")


func _on_restart_button_pressed() -> void:
	get_tree().change_scene_to_file(failed_level)
