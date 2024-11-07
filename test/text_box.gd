extends Control

@onready var label = $Label

var text_to_show: Message.Instruction = Message.Instruction.new(
	"first message",
	"Enter or Space"
)

var message: Message.Instruction


func _ready() -> void:
	text_to_show.next = Message.Instruction.new(
		"second message",
		"Enter or Space"
	)
	text_to_show.next.next = Message.Instruction.new(
		"third message",
		"Enter or Space"
	)
	message = text_to_show


func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed(GameInputEvent.action_keys[message.needed_action_key]):
		if message.next != null:
			message = message.next
		print(message)

	label.text = message.message
