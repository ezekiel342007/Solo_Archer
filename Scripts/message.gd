extends Node

class Instruction:
	var message: String
	var needed_action_key: String
	var next: Instruction = null
	
	func _init(init_message: String, init_needed_action_key: String) -> void:
		self.message = init_message
		self.needed_action_key = init_needed_action_key
	
	func add_instruction(next_instruction: Instruction) -> Instruction:
		self.next = next_instruction
		return self


class ConversationLine:
	var speaker: CharacterBody2D
	var receivers: Array[CharacterBody2D]
	var message: String
	var next_line: ConversationLine = null
	var needed_action_key: String

	func _init(init_speaker: CharacterBody2D, init_message: String, init_needed_action_key: String) -> void:
		self.speaker = init_speaker
		self.message = init_message
		self.needed_action_key = init_needed_action_key

	func add_line(new_line: ConversationLine) -> ConversationLine:
		self.next_line = new_line
		return self
