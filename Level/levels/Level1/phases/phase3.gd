extends NodeState

@onready var player: CharacterBody2D = %Player
@onready var game_screen: CanvasLayer = %GameScreen
@onready var goblin_spawn_position: Marker2D = $"../../GoblinSpawnPosition"
@onready var camera: Camera2D = $"../../Camera2D2"
@onready var goblin = preload("res://Characters/Goblins/BomberGoblin/goblin.tscn")

var surviving_commoner
var battle: bool = false
var skip_with_mouse_btn: bool = false
var conversation: bool = true
var is_player: bool
var conversaton_line_no
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


func on_input(_event) -> void:
	if _event is InputEventKey and _event.pressed:
		if !battle:
			if (_event.keycode == KEY_ENTER or _event.keycode == KEY_SPACE) and skip_with_mouse_btn == false:
				if conversation:
					# If we aren't at the last line
					if i < conversation_lines.size() - 1:
						i += 1
					# If we are at the last line
					elif i >= conversation_lines.size() - 1:
						conversation = false
						i = 0
					get_conversation_line(i)
				else:
					if i < directions.size() - 1:
						i += 1
					get_directions(i)

	if _event is InputEventMouseButton and _event.pressed:
		if _event.button_index == MOUSE_BUTTON_LEFT and skip_with_mouse_btn:
			i += 1
			skip_with_mouse_btn = false
			get_directions(i)

	if game_screen.narration_text == "":
		game_screen.narrating = false
		transition.emit("Phase4")


func enter() -> void:
	surviving_commoner = $"../../Commoner"
	player.can_move = false
	game_screen.narrating = true

	conversaton_line_no = conversation_lines.size()
	get_conversation_line(0)


func get_conversation_line(index: int) -> void:
	var tween = get_tree().create_tween()
	if conversation:
		var conversation_line: String = conversation_lines[index]["Message"]
		var speaker: String = conversation_lines[index]["Speaker"]
		if speaker == "Player":
			tween.tween_property(surviving_commoner, "modulate", Color8(64, 64, 64), 0.1)
			tween.tween_property(player, "modulate", Color8(255, 255, 255), 0.1)
		elif speaker == "Commoner":
			tween.tween_property(player, "modulate", Color8(64, 64, 64), 0.1)
			tween.tween_property(surviving_commoner, "modulate", Color8(255, 255, 255), 0.1)
		elif speaker == "Goblin in sight":
			spawn_goblin()
			move_and_zoom_camera_from(goblin_spawn_position.global_position)

		game_screen.narration_text = conversation_line
		game_screen.key_direction = "Enter or Space key"
	else:
		player.can_move = true
		tween.tween_property(surviving_commoner, "modulate", Color8(255, 255, 255), 0.1)
		get_directions(0)


func get_directions(index: int) -> void:
	var direction_line: String = directions[index]["Message"]
	var direction: String = directions[index]["Direction"]
	if direction== "Left mouse button":
		skip_with_mouse_btn = true
	game_screen.narration_text = direction_line
	game_screen.key_direction = direction


func spawn_goblin() -> void:
	var goblin_instance: CharacterBody2D = goblin.instantiate() as CharacterBody2D
	goblin_instance.global_position = goblin_spawn_position.global_position
	get_parent().get_parent().add_child(goblin_instance)


func move_and_zoom_camera_from(position: Vector2) -> void:
	camera.transition_from(position)


func exit() -> void:
	player.can_move = true
	goblin_spawn_position.queue_free()
