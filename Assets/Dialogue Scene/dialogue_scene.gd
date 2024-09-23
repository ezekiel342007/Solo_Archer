extends ColorRect
class_name DialogueScene

var characters: Array[CharacterBody2D]
var dialogue_lines: Array[Dictionary]

@onready var participants: Node = $"/Participants"

func _init(character_locations: Array[CharacterBody2D], dialogue_details: Array[Dictionary]) -> void:
	characters = character_locations
	dialogue_lines = dialogue_details


func _ready():
	for character in characters:
		participants.add_child(character.new())
