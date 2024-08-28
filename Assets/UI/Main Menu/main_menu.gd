extends Control


func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://Level/levels/Level1/level1.tscn")


func _on_exit_button_pressed():
	get_tree().quit()
