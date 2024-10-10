extends ColorRect

@onready var quit_options = preload("res://Assets/UI/Pause Menu/quit_options.tscn")

var paused_level_path: NodePath


func _on_resume_button_pressed() -> void:
	get_tree().paused = false
	queue_free()


func _on_restart_button_pressed() -> void:
	pass # Replace with function body.


func _on_settings_button_pressed() -> void:
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	get_parent().add_child(quit_options.instantiate())
