extends BaseLevel

var phase1: bool = false
var phase2: bool = false
var phase3: bool = false
var phase4: bool = false
var phase5: bool = false
var dialogue_phase: bool = false


static var phase_2_player_with_commander := [
	{
		"Speaker": "Captain",
		"Message": "You lost or somethin' brother?",
		"Receivers": ["Player", "Knight1", "Knight2", "Knight3", "Knight4"],
		"Action_key": "Enter or Space"
	},
	{
		"Speaker": "Captain",
		"Message": "What's that in your hand, this is no place for hunter, y'know what I'm sayin'",
		"Receivers": ["Player", "Knight1", "Knight2", "Knight3", "Knight4"],
		"Action_key": "Enter or Space"
	},
	{
		"Speaker": "Player",
		"Message": "...",
		"Receivers": ["Captain", "Knight1", "Knight2", "Knight3", "Knight4"],
		"Action_key": "Enter or Space"
	},
	{
		"Speaker": "Player",
		"Message": "Who are you supposed to be?",
		"Receivers": ["Captain", "Knight1", "Knight2", "Knight3", "Knight4"],
		"Action_key": "Enter or Space"
	},
	{
		"Speaker": "Knight1",
		"Message": "Nice!!!",
		"Receivers": ["Captain", "Player"],
		"Action_key": "Enter or Space"
	},
	{
		"Speaker": "Captain",
		"Message": "Wrong question kid, it's what do you have for us?",
		"Receivers": ["Player", "Knight1", "Knight2", "Knight3", "Knight4"],
		"Action_key": "Enter or Space"
	},
	{
		"Speaker": "Player",
		"Message": "You know, we don't take to kindly to deserters in %s" % GameManagement.village_name_slang1,
		"Receivers": ["Captain", "Knight1", "Knight2", "Knight3", "Knight4"],
		"Action_key": "Enter or Space"
	},
	{
		"Speaker": "Knight3",
		"Message": "Tch!, you don't know what you're talking about",
		"Receivers": ["Captain", "Knight1", "Knight2", "Player", "Knight4"],
		"Action_key": "Enter or Space"
	},
	{
		"Speaker": "Knight2",
		"Message": "You call us deserters? You weren't even in the battle!",
		"Receivers": ["Captain", "Knight1", "Player", "Knight3", "Knight4"],
		"Action_key": "Enter or Space"
	},
	{
		"Speaker": "Knight2",
		"Message": "Who do you think you are?",
		"Receivers": ["Captain", "Knight1", "Player", "Knight3", "Knight4"],
		"Action_key": "Enter or Space"
	},
	{
		"Speaker": "Captain",
		"Message": "Shut up!!",
		"Receivers": ["Player", "Knight1", "Knight2", "Knight3", "Knight4"],
		"Action_key": "Enter or Space"
	},
	{
		"Speaker": "Knight2",
		"Message": "...",
		"Receivers": ["Player", "Knight1", "Captain", "Knight3", "Knight4"],
		"Action_key": "Enter or Space"
	},
	{
		"Speaker": "Captain",
		"Message": "Deserters? I gues... it's not too far off",
		"Receivers": ["Player", "Knight1", "Knight2", "Knight3", "Knight4"],
		"Action_key": "Enter or Space"
	},
	{
		"Speaker": "Knight4",
		"Message": "Captain!",
		"Receivers": ["Player", "Knight1", "Captain", "Knight3", "Captain"],
		"Action_key": "Enter or Space"
	},
	{
		"Speaker": "Knight4",
		"Message": "Don't give me that nonsense!! We are the only ones left",
		"Receivers": ["Player", "Knight1", "Captain", "Knight3", "Captain"],
		"Action_key": "Enter or Space"
	}
]
