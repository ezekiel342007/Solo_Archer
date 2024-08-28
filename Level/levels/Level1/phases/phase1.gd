extends NodeState

@export var enemy_node: Node

@onready var game_screen = $"../../Player/Camera2D2/GameScreen"
@onready var bomber_goblins = preload("res://Characters/Goblins/BomberGoblin/goblin.tscn")

var i: int = 0
var skip_key: String = "ui_accept"
var current_section_keys: Array
var current_section: Dictionary
var message_sections: Array[String]
var level_messages: Dictionary = {
	"Greeting": {
		"Hey there": "Enter",
		"Welcome to Solo Archer and stuff": "Enter"
	},
	"Movements": {
		"First, Let's start with the basics": "Enter",
		"Use the \"E\" key to move forward": "E",
		"Use the \"D\" key to move backward": "D",
		"Use the \"F\" key to move to your right": "F",
		"Use the \"A\" key to move to your left": "A",
	}
}


func enter() -> void:
	# Saving each section of the message
	for section in level_messages.keys():
		message_sections.append(section)

	if message_sections.size() > 0:
		# Get the keys (the messages) of each section
		current_section = level_messages[message_sections[0]]
		current_section_keys = current_section.keys()

	game_screen.narrating = true


func _input(event):
	if event is InputEventKey and event.pressed:
		if event.key_code == skip_key:


func on_physics_process(_delta: float) -> void:
	
	if Input.is_action_just_pressed(skip_key):
		i += 1
	
	if i == current_section.size():
		i = 0

	game_screen.narration_text = current_section_keys[i]
	game_screen.key_direction = current_section[current_section_keys[i]]
