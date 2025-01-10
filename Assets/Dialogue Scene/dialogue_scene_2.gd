extends Control

@export var participants_node: Node;
@export var narration_banner: NarrationBanner;

@onready var player = $ColorRect/Participants/Player;
@onready var knight1 = $ColorRect/Participants/Knight1;
@onready var knight2 = $ColorRect/Participants/Knight2;
@onready var knight3 = $ColorRect/Participants/Knight3;
@onready var knight4 = $ColorRect/Participants/Knight4;
@onready var knight_captain = $ColorRect/Participants/KnightCaptain;


func _ready() -> void:
	player.aiming = false;
	for character in participants_node.get_children():
		character.get_node("AnimatedSprite2D").stop();

	narration_banner.conversation_script = Message.make_script(
		Messages.level2_dialogue_lines,
		{
			"Captain": knight_captain,
			"Knight1": knight1,
			"Knight2": knight2,
			"Knight3": knight3,
			"Knight4": knight4,
			"Player": player
		}
	)

	narration_banner.have_shown_message.connect(
		func (): get_tree().change_scene_to_file("res://Assets/UI/Main Menu/main_menu.tscn")
	)
