extends Node

class Instruction:
	var message: String
	var vital: bool = false
	var needed_action_key: String
	var next: Instruction = null
	
	func _init(
			init_message: String,
			init_needed_action_key: String,
			init_vital: bool = false
		) -> void:
		self.message = init_message
		self.vital = init_vital
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
	var vital: bool = false

	func _init(
			init_speaker: CharacterBody2D,
			init_message: String,
			init_needed_action_key: String,
			init_vital: bool = false
		) -> void:
		self.vital = init_vital
		self.speaker = init_speaker
		self.message = init_message
		self.needed_action_key = init_needed_action_key

	func add_line(new_line: ConversationLine) -> ConversationLine:
		self.next_line = new_line
		return self
