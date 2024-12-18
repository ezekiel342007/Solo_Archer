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
			init_receivers: Array[CharacterBody2D],
			init_message: String,
			init_needed_action_key: String,
			init_vital: bool = false
		) -> void:
		self.vital = init_vital
		self.speaker = init_speaker
		self.receivers = init_receivers
		self.message = init_message
		self.needed_action_key = init_needed_action_key

	func add_line(new_line: ConversationLine) -> ConversationLine:
		self.next_line = new_line
		return self


func make_script(script: Array[Dictionary], cast: Dictionary) -> ConversationLine:
	if script.size() < 1:
		return null
	else:
		var receivers: Array[CharacterBody2D]
		for receiver: String in script[0]["Receivers"]:
			receivers.append(cast[receiver])
		var new_script = ConversationLine.new(
			cast[script[0]["Speaker"]],
			receivers,
			script[0]["Message"],
			script[0]["Action_key"]
		).add_line(make_script(script.slice(1, script.size()), cast))

		return new_script
	

func make_instructions_list(instructions: Array[Dictionary]) -> Instruction:
	if instructions.size() < 1:
		return null
	else:
		var new_instruction: Instruction = Instruction.new(
			instructions[0]["Message"],
			instructions[0]["Action_key"],
			instructions[0]["Vital"]
		).add_instruction(make_instructions_list(instructions.slice(1, instructions.size())))

		return new_instruction
