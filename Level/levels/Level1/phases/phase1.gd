extends NodeState

@export var enemy_node: Node

@onready var game_screen = $"../../Player/Camera2D2/GameScreen"
@onready var bomber_goblins = preload("res://Characters/Goblins/BomberGoblin/goblin.tscn")

var i: int = 0
var j: int = 0
var regular_skip: bool
var current_section_keys: Array
var current_section: Dictionary
var message_sections: Array[String]

var skip_keys: Dictionary = {
	"Enter": KEY_ENTER,
	"A": KEY_A,
	"F": KEY_F,
	"E": KEY_E,
	"D": KEY_D
}

var level_messages: Dictionary = {
	"Greeting": {
		"Hey there": "Enter",
		"Welcome to Solo Archer and stuff": "Enter",
		"First, Let's start with the basics": "Enter",
	},
	"Movements": {
		"Use the \"E\" key to move forward": "E",
		"Use the \"D\" key to move backward": "D",
		"Use the \"F\" key to move to your right": "F",
		"Use the \"A\" key to move to your left": "A",
	},
	"Instruction": {
		"Go to the man the arrow is pointing to": ""
	}
}


func enter() -> void:
	# Saving each section of the message
	for section in level_messages.keys():
		message_sections.append(section)

	if message_sections.size() > 0:
		# Get the keys (the messages) of each section
		current_section = level_messages[message_sections[j]]
		current_section_keys = current_section.keys()

	game_screen.narrating = true


func _input(event):
	if event is InputEventKey and event.pressed:
		if game_screen.narration_text != "Go to the man the arrow is pointing to":
			if event.keycode == skip_keys["Enter"] and regular_skip and i < current_section_keys.size():
				i += 1

			if event.keycode == skip_keys["E"] and !regular_skip and i < current_section_keys.size() and game_screen.key_direction == "E":
				i += 1

			if event.keycode == skip_keys["A"] and !regular_skip and i < current_section_keys.size() and game_screen.key_direction == "A":
				i += 1

			if event.keycode == skip_keys["D"] and !regular_skip and i < current_section_keys.size() and game_screen.key_direction == "D":
				i += 1

			if event.keycode == skip_keys["F"] and !regular_skip and i < current_section_keys.size() and game_screen.key_direction == "F":
				i += 1

			if i == current_section_keys.size():
				j += 1	
				i = 0
		else:
			game_screen.narrating = false
			# Transition to the second phase
			transition.emit("Phase2")


func on_physics_process(_delta: float) -> void:
	current_section = level_messages[message_sections[j]]
	current_section_keys = current_section.keys()

	game_screen.narration_text = current_section_keys[i]
	if message_sections[j] == "Movements":
		regular_skip = false
	else:
		regular_skip = true
	game_screen.key_direction = current_section[current_section_keys[i]]
