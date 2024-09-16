extends NodeState
class_name Dialogue

enum Emotion {
	SCARED,
	CALM,
	NERVOUS,
	ANGRY,
	ANNOYED
}

var conversation_lines: Array[Dictionary] = [
	{
		"Speaker": "Commoner",
		"Message": "Wahh!!! Stay away! I don't have anything left!",
		"Emotion": Emotion.SCARED
	},
	{
		"Speaker": "Player",
		"Message": "what are you even talking about",
		"Emotion": Emotion.CALM
	},
	{
		"Speaker": "Player",
		"Message": "what happened here?",
		"Emotion": Emotion.CALM
	},
	{
		"Speaker": "Commoner",
		"Message": "wha.. wh.. who are you?",
		"Emotion": Emotion.SCARED
	},
	{
		"Speaker": "Player",
		"Message": "answer my question and I'll answer yours",
		"Emotion": Emotion.CALM
	},
	{
		"Speaker": "Commoner",
		"Message": "well... um...",
		"Emotion": Emotion.NERVOUS
	},
	{
		"Speaker": "Player",
		"Message": "c'mon say it!",
		"Emotion": Emotion.ANNOYED
	},
	{
		"Speaker": "Commoner",
		"Message": "Argh! We were invaded okay! tch",
		"Emotion": Emotion.ANGRY
	},
	{
		"Speaker": "Player",
		"Message": "...",
		"Emotion": Emotion.CALM
	},
	{
		"Speaker": "Player",
		"Message": "why was is so hard to say?",
		"Emotion": Emotion.CALM
	},
	{
		"Speaker": "Commoner",
		"Message": "you really aren't from around here, are you?",
		"Emotion": Emotion.CALM
	},
	{
		"Speaker": "Player",
		"Message": "yeah kind of",
		"Emotion": Emotion.CALM
	},
	{
		"Speaker": "Commoner",
		"Message": "well, we were invaded by goblins and...",
		"Emotion": Emotion.CALM
	},
	{
		"Speaker": "Player",
		"Message": "Ha! Ha! Ha! Ha!",
		"Emotion": Emotion.CALM
	},
	{
		"Speaker": "Player",
		"Message": "you mea... Ha! Ha! goblins beat you guy... Ha! Ha!",
		"Emotion": Emotion.CALM
	},
	{
		"Speaker": "Commoner",
		"Message": "...",
		"Emotion": Emotion.CALM
	},
	{
		"Speaker": "Player",
		"Message": "so how come?",
		"Emotion": Emotion.CALM
	},
	{
		"Speaker": "Commoner",
		"Message": "well this village is currently undergoing independence negotiations with the King",
		"Emotion": Emotion.CALM
	},
	{
		"Speaker": "Player",
		"Message": "ooh, I get it",
		"Emotion": Emotion.CALM
	},
	{
		"Speaker": "Commoner",
		"Message": "...",
		"Emotion": Emotion.CALM
	},
	{
		"Speaker": "Player",
		"Message": "so basically, you've been taxed too dry to fund a proper defence,",
		"Emotion": Emotion.CALM
	},
	{
		"Speaker": "Player",
		"Message": "and didn't want to ask help from the one you don't want to have anything to do with",
		"Emotion": Emotion.CALM
	},
	{
		"Speaker": "Commoner",
		"Message": "and they packed some new weapons",
		"Emotion": Emotion.CALM
	},
	{
		"Speaker": "Player",
		"Message": "ever resourceful aren't they?",
		"Emotion": Emotion.CALM
	},
	{
		"Speaker": "Commoner",
		"Message": "Mhm",
		"Emotion": Emotion.CALM
	},
	{
		"Speaker": "Player",
		"Message": "so where's everyone?",
		"Emotion": Emotion.CALM
	},
	{
		"Speaker": "Commoner",
		"Message": "They fled",
		"Emotion": Emotion.CALM
	},
	{
		"Speaker": "Player",
		"Message": "and you?",
		"Emotion": Emotion.CALM
	},
	{
		"Speaker": "Commoner",
		"Message": "I passed out, I just wanna take some stuff and scram",
		"Emotion": Emotion.CALM
	},
	{
		"Speaker": "Player",
		"Message": "what were you planning to do about him?",
		"Emotion": Emotion.CALM
	},
	{
		"Speaker": "Goblin in sight",
		"Message": " ",
		"Emotion": Emotion.SCARED
	},
	{
		"Speaker": "Commoner",
		"Message": "Ah!!!",
		"Emotion": Emotion.SCARED
	},
	{
		"Speaker": "Player",
		"Message": "don't worry",
		"Emotion": Emotion.CALM
	}
]

var directions: Array[Dictionary] = [
	{
		"Message": "Use the mouse/touchpad to aim your bow and left-click to shoot",
		"Direction": "Left mouse button"
	},
	{
		"Message": "You can also use the \"I\", \"J\", \"K\", \"L\" keys to shoot UP, LEFT, DOWN and RIGHT respectively",
		"Direction": "Enter or Space key"
	},
	{
		"Message": "Go and defeat the goblin",
		"Direction": ""
	},
	{
		"Message": "",
		"Direction": ""
	}
]
