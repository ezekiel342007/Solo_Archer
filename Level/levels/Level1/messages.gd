extends Node
class_name Messages

static var player: CharacterBody2D = Player.new()
static var commoner: CharacterBody2D = Commoner.new()

static var phase3_conversation_cast: Dictionary = {
	"Player": player,
	"Commoner": commoner
}
static var phase1_level_messages: Message.Instruction = Message.Instruction.new(
	"Hey there",
	"Enter or Space"
).add_instruction(
	Message.Instruction.new(
		"You're right on time",
		"Enter or Space"
	).add_instruction(
		Message.Instruction.new(
			"Sorry no time to explain, let's start with the basics",
			"Enter or Space"
		).add_instruction(
			Message.Instruction.new(
				"Use the \"E\" key to move forward",
				"E"
			).add_instruction(
				Message.Instruction.new(
					"Use the \"D\" key to move backward",
					"D"
				).add_instruction(
					Message.Instruction.new(
						"Use the \"F\" key to move to your right",
						"F"
					).add_instruction(
						Message.Instruction.new(
							"Use the \"S\" key to move to your left",
							"S"
						).add_instruction(
							Message.Instruction.new(
								"You truly learn fast, just like I he...",
								"Enter or Space"
							).add_instruction(
								Message.Instruction.new(
									"I mean, go to the man the arrow is pointing to quickly!",
									"Enter or Space"
								)
							)
						)
					)
				)
			)
		)
	)
)
static var phase3_conversation_lines1: Message.ConversationLine = Message.make_script(
	[
		{
			"Speaker": "Commoner",
			"Message": "Wahh!!! Stay away! I don't have anything left!",
			"Receivers": ["Player"],
			"Action_key": "Enter or Space"
		},
		{
			"Speaker": "Player",
			"Message": "what are you even talking about",
			"Receivers": ["Commoner"],
			"Action_key": "Enter or Space"
		},
		{
			"Speaker": "Player",
			"Message": "what happened here?",
			"Receivers": ["Commoner"],
			"Action_key": "Enter or Space"
		},
		{
			"Speaker": "Commoner",
			"Message": "wha.. wh.. who are you?",
			"Receivers": ["Player"],
			"Action_key": "Enter or Space"
		},
		{
			"Speaker": "Player",
			"Message": "answer my question and I'll answer yours",
			"Receivers": ["Commoner"],
			"Action_key": "Enter or Space"
		},
		{
			"Speaker": "Commoner",
			"Message": "well... um...",
			"Receivers": ["Player"],
			"Action_key": "Enter or Space"
		},
		{
			"Speaker": "Player",
			"Message": "c'mon say it!",
			"Receivers": ["Commoner"],
			"Action_key": "Enter or Space"
		},
		{
			"Speaker": "Commoner",
			"Message": "Argh! We were invaded okay! tch",
			"Receivers": ["Player"],
			"Action_key": "Enter or Space"
		},
		{
			"Speaker": "Player",
			"Message": "...",
			"Receivers": ["Commoner"],
			"Action_key": "Enter or Space"
		},
		{
			"Speaker": "Player",
			"Message": "why was is so hard to say?",
			"Receivers": ["Commoner"],
			"Action_key": "Enter or Space"
		},
		{
			"Speaker": "Commoner",
			"Message": "you really aren't from around here, are you?",
			"Receivers": ["Player"],
			"Action_key": "Enter or Space"
		},
		{
			"Speaker": "Player",
			"Message": "yeah kind of",
			"Receivers": ["Commoner"],
			"Action_key": "Enter or Space"
		},
		{
			"Speaker": "Commoner",
			"Message": "well, we were invaded by goblins and...",
			"Receivers": ["Player"],
			"Action_key": "Enter or Space"
		},
		{
			"Speaker": "Player",
			"Message": "Ha! Ha! Ha! Ha!",
			"Receivers": ["Commoner"],
			"Action_key": "Enter or Space"
		},
		{
			"Speaker": "Player",
			"Message": "you mea... Ha! Ha! goblins beat you guy... Ha! Ha!",
			"Receivers": ["Commoner"],
			"Action_key": "Enter or Space"
		},
		{
			"Speaker": "Commoner",
			"Message": "...",
			"Receivers": ["Player"],
			"Action_key": "Enter or Space"
		},
		{
			"Speaker": "Player",
			"Message": "so how come?",
			"Receivers": ["Commoner"],
			"Action_key": "Enter or Space"
		},
		{
			"Speaker": "Commoner",
			"Message": "well this village is currently undergoing independence negotiations with the King",
			"Receivers": ["Player"],
			"Action_key": "Enter or Space"
		},
		{
			"Speaker": "Player",
			"Message": "ooh, I get it",
			"Receivers": ["Commoner"],
			"Action_key": "Enter or Space"
		},
		{
			"Speaker": "Commoner",
			"Message": "...",
			"Receivers": ["Player"],
			"Action_key": "Enter or Space"
		},
		{
			"Speaker": "Player",
			"Message": "so basically, you've been taxed too dry to fund a proper defence,",
			"Receivers": ["Commoner"],
			"Action_key": "Enter or Space"
		},
		{
			"Speaker": "Player",
			"Message": "and didn't want to ask help from the one you don't want to have anything to do with",
			"Receivers": ["Commoner"],
			"Action_key": "Enter or Space"
		},
		{
			"Speaker": "Commoner",
			"Message": "and they packed some new weapons",
			"Receivers": ["Player"],
			"Action_key": "Enter or Space"
		},
		{
			"Speaker": "Player",
			"Message": "ever resourceful aren't they?",
			"Receivers": ["Commoner"],
			"Action_key": "Enter or Space"
		},
		{
			"Speaker": "Commoner",
			"Message": "Mhm",
			"Receivers": ["Player"],
			"Action_key": "Enter or Space"
		},
		{
			"Speaker": "Player",
			"Message": "so where's everyone?",
			"Receivers": ["Commoner"],
			"Action_key": "Enter or Space"
		},
		{
			"Speaker": "Commoner",
			"Message": "They fled",
			"Receivers": ["Player"],
			"Action_key": "Enter or Space"
		},
		{
			"Speaker": "Player",
			"Message": "and you?",
			"Receivers": ["Commoner"],
			"Action_key": "Enter or Space"
		},
		{
			"Speaker": "Commoner",
			"Message": "I passed out, I just wanna take some stuff and scram",
			"Receivers": ["Player"],
			"Action_key": "Enter or Space"
		},
		{
			"Speaker": "Player",
			"Message": "what were you planning to do about him?",
			"Receivers": ["Commoner"],
			"Action_key": "Enter or Space"
		},
		{
			"Speaker": "Player",
			"Message": "Goblin in sight",
			"Receivers": ["Commoner"],
			"Action_key": "Enter or Space"
		},
	],
	phase3_conversation_cast
)

static var phase3_conversation_lines2: Message.ConversationLine = Message.make_script(
	[
		{
			"Speaker": "Commoner",
			"Message": "Ah!!!",
			"Receivers": ["Player"],
			"Action_key": "Enter or Space"
		},
		{
			"Speaker": "Player",
			"Message": "don't worry",
			"Receivers": ["Commoner"],
			"Action_key": "Enter or Space"
		}
	],
	phase3_conversation_cast
)


static var phase3_directions = Message.Instruction.new(
	"Use the mouse/touchpad to aim your bow and left-click to shoot",
	"Enter or Space"
).add_instruction(
	Message.Instruction.new(
		"You can also use the \"I\", \"J\", \"K\", \"L\" keys to shoot UP, LEFT, DOWN and RIGHT respectively",
		"Enter or Space"
	).add_instruction(
		Message.Instruction.new(
			"Go and defeat the goblin",
			""
		)
	)
)

static var phase4_instruction = Message.Instruction.new(
	"There are others, follow the arrow",
	""
)

static var level1_dialogue_scene_lines: Array[Dictionary]= [
	{
		"Speaker": "Commoner",
		"Message": "So where are you heading now, these are dangerous times",
		"Receivers": ["Player"],
		"Action_key": "Enter or Space"
	},
	{
		"Speaker": "Player",
		"Message": "Back to Clifford Hills",
		"Receivers": ["Commoner"],
		"Action_key": "Enter or Space"
	},
	{
		"Speaker": "Commoner",
		"Message": "so that's where you're from",
		"Receivers": ["Player"],
		"Action_key": "Enter or Space"
	},
	{
		"Speaker": "Player",
		"Message": "whatever",
		"Receivers": ["Commoner"],
		"Action_key": "Enter or Space"
	},
	{
		"Speaker": "Player",
		"Message": "have you heard anything from there?",
		"Receivers": ["Commoner"],
		"Action_key": "Enter or Space"
	},
	{
		"Speaker": "Commoner",
		"Message": "Only that the advance guard sent to ward of some invading goblins were defeated",
		"Receivers": ["Player"],
		"Action_key": "Enter or Space"
	},
	{
		"Speaker": "Commoner",
		"Message": "also the goblins that attacked here were so disorganised, I take it that this was just a side quest,",
		"Receivers": ["Player"],
		"Action_key": "Enter or Space"
	},
	{
		"Speaker": "Commoner",
		"Message": "and the real invasion was actually on Clifford Hills",
		"Receivers": ["Player"],
		"Action_key": "Enter or Space"
	}
]
