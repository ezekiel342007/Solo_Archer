extends Node2D
class_name BaseLevel

@onready var player: CharacterBody2D = %Player
@onready var game_screen = %GameScreen
@onready var pause_menu = preload("res://Assets/UI/Pause Menu/pause_menu.tscn")


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.keycode == KEY_ESCAPE:
		game_screen.margin_container.add_child(deploy_pause_menu_instance())
		get_tree().paused = true


func deploy_pause_menu_instance() -> ColorRect:
	var pause_menu_instance: ColorRect = pause_menu.instantiate() as ColorRect
	pause_menu_instance.paused_level_path = scene_file_path
	return pause_menu_instance


func deploy_narration_banner(
	messages: Message.Instruction = null,
	needed_signal: StringName = &"",
	signal_callable: Callable = Callable(),
	conversation_script: Message.ConversationLine = null
	) -> NarrationBanner:
	var narration_banner_instance: Control = preload("res://Assets/UI/NarrationBanner/narration_banner.tscn").instantiate() as Control
	if messages != null:
		narration_banner_instance.message_for_banner = messages
	elif conversation_script != null:
		narration_banner_instance.conversation_script = conversation_script
	if signal_callable.is_valid() and needed_signal != &"":
		narration_banner_instance.connect(needed_signal, signal_callable)
	return narration_banner_instance
