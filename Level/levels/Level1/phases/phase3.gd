extends NodeState

@onready var player = $"../../Player"
var surviving_commoner
@onready var game_screen = $"../../Player/Camera2D2/GameScreen"

var conversation: bool = true
var is_player: bool
var i: int = 0

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
		"Message": "",
		"Emotion": Emotion.SCARED
	},
	{
		"Speaker": "Commoner",
		"Message": "Ah..",
		"Emotion": Emotion.SCARED
	},
	{
		"Speaker": "Player",
		"Message": "don't worry",
		"Emotion": Emotion.CALM
	}
]


func on_input(event) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ENTER:
			i += 1
			get_conversation_line(i)


func enter() -> void:
	surviving_commoner = $"../../Commoner"
	game_screen.narrating = true
	get_conversation_line(0)


func get_conversation_line(index: int) -> void:
	var tween = get_tree().create_tween()
	var conversation_line: String = conversation_lines[index]["Message"]
	var speaker: String = conversation_lines[index]["Speaker"]
	var emotion: int = conversation_lines[index]["Emotion"]
	if speaker == "Player":
		tween.tween_property(surviving_commoner, "modulate", Color8(64, 64, 64), 0.1)
		tween.tween_property(player, "modulate", Color8(255, 255, 255), 0.1)
	elif speaker == "Commoner":
		tween.tween_property(player, "modulate", Color8(64, 64, 64), 0.1)
		tween.tween_property(surviving_commoner, "modulate", Color8(255, 255, 255), 0.1)

	if emotion == Emotion.ANGRY:
		tween.tween_property(game_screen.narration_banner, "modulate", Color8(211, 62, 47), 0.1)
	elif emotion == Emotion.SCARED:
		tween.tween_property(game_screen.narration_banner, "modulate", Color8(100, 100, 100), 0.1)
	elif emotion == Emotion.NERVOUS:
		tween.tween_property(game_screen.narration_banner, "modulate", Color8(255, 221, 5), 0.1)
	elif emotion == Emotion.CALM:
		tween.tween_property(game_screen.narration_banner, "modulate", Color8(255, 255, 255), 0.1)

	game_screen.narration_text = conversation_line
	game_screen.key_direction = "Enter"
