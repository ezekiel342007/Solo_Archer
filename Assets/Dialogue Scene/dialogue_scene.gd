extends Node

@onready var participants: Node = $Participants
@onready var narration_banner: NarrationBanner = %NarrationBanner
@onready var player: Player = $ColorRect/Participants/Player
@onready var commoner: Commoner = $ColorRect/Participants/Commoner
@onready var color_rect: ColorRect = $ColorRect


func _ready() -> void:
	narration_banner.conversation_script = Message.make_script(
		Messages.level1_dialogue_scene_lines,
		{"Player": player, "Commoner": commoner}
	)
	narration_banner.have_shown_message.connect(
		func (): get_tree().change_scene_to_file("res://Assets/UI/Main Menu/main_menu.tscn")
	)
