extends Control
class_name NarrationBanner

@onready var narration_label: Label = %NarrationLabel
@onready var key_direction_label: Label = %KeyDirectionLabel

signal see_goblin
signal have_shown_message
var message_for_banner: Message.Instruction
var conversation_script: Message.ConversationLine


func _ready() -> void:
	if message_for_banner:
		narration_label.text = message_for_banner.message
		if message_for_banner.needed_action_key == "":
			key_direction_label.text = ""
		else:
			key_direction_label.text = "Press " + message_for_banner.needed_action_key

	if conversation_script:
		var modulate_tween = get_tree().create_tween()
		narration_label.text = conversation_script.message
		key_direction_label.text = "Press Enter or Space"
		modulate_tween.tween_property(conversation_script.speaker, "modulate", Color8(255, 255, 255), 0.1)
		for receiver in conversation_script.receivers:
			modulate_tween.tween_property(receiver, "modulate", Color8(64, 64, 64), 0.1)


func _physics_process(_delta: float) -> void:
	if message_for_banner:
		narration_label.text = message_for_banner.message
		if message_for_banner.needed_action_key == "":
			key_direction_label.text = ""
		else:
			key_direction_label.text = "Press " + message_for_banner.needed_action_key

		var action_key_key: String = message_for_banner.needed_action_key
		var action_key_needed: StringName = GameInputEvent.action_keys[action_key_key]
				
		if Input.is_action_just_pressed(action_key_needed):
			if message_for_banner.next != null:
				message_for_banner = message_for_banner.next
			else:
				have_shown_message.emit()
				queue_free()

	if conversation_script:
		var modulate_tween = get_tree().create_tween()
		if conversation_script.message == "Goblin in sight":
			see_goblin.emit()
			queue_free()
		narration_label.text = conversation_script.message
		key_direction_label.text = "Press Enter or Space"
		modulate_tween.tween_property(conversation_script.speaker, "modulate", Color8(255, 255, 255), 0.1)
		for receiver in conversation_script.receivers:
			modulate_tween.tween_property(receiver, "modulate", Color8(64, 64, 64), 0.1)
		var action_key_key: String = conversation_script.needed_action_key
		var action_key_needed: StringName = GameInputEvent.action_keys[action_key_key]
		if Input.is_action_just_pressed(action_key_needed):
			if conversation_script.next_line != null:
				conversation_script = conversation_script.next_line
			else:
				have_shown_message.emit()
				queue_free()
