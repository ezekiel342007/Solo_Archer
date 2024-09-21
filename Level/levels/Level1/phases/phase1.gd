extends NodeState

@export var enemy_node: Node

@onready var game_screen = %GameScreen
@onready var level1 = $"../../"

var i: int = 0
var j: int = 0
var regular_skip: bool
var current_section_keys: Array
var current_section: Dictionary
var message_sections: Array[String]

var skip_keys: Dictionary = {
	"Enter": KEY_ENTER,
	"Space": KEY_SPACE,
	"S": KEY_S,
	"F": KEY_F,
	"E": KEY_E,
	"D": KEY_D
}

var level_messages: Dictionary = {
	"Greeting": {
		"Hey there": "Enter or Space",
		"You're right on time": "Enter or Space",
		"Sorry no time to explain, let's start with the basics": "Enter or Space",
	},
	"Movements": {
		"Use the \"E\" key to move forward": "E",
		"Use the \"D\" key to move backward": "D",
		"Use the \"F\" key to move to your right": "F",
		"Use the \"S\" key to move to your left": "S",
	},
	"Instruction": {
		"You truly learn fast, just like I he...": "Enter or Space",
		"I mean, go to the man the arrow is pointing to quickly!": ""
	}
}


func enter() -> void:
	level1.phase1 = true
	# Saving each section of the message
	for section in level_messages.keys():
		message_sections.append(section)

	if message_sections.size() > 0:
		# Get the keys (the messages) of each section
		current_section = level_messages[message_sections[j]]
		current_section_keys = current_section.keys()

	game_screen.narrating = true


func on_input(event):
	if event is InputEventKey and event.pressed:
		if game_screen.narration_text != "I mean, go to the man the arrow is pointing to quickly!":
			if (event.keycode == skip_keys["Space"] or event.keycode == skip_keys["Enter"]) and regular_skip and i < current_section_keys.size():
				i += 1

			if event.keycode == skip_keys["E"] and !regular_skip and i < current_section_keys.size() and game_screen.key_direction == "E":
				i += 1

			if event.keycode == skip_keys["S"] and !regular_skip and i < current_section_keys.size() and game_screen.key_direction == "S":
				i += 1

			if event.keycode == skip_keys["D"] and !regular_skip and i < current_section_keys.size() and game_screen.key_direction == "D":
				i += 1

			if event.keycode == skip_keys["F"] and !regular_skip and i < current_section_keys.size() and game_screen.key_direction == "F":
				i += 1

			if i == current_section_keys.size():
				j += 1	
				i = 0
		else:
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


func exit() -> void:
	game_screen.narrating = false
	level1.phase1 = false
