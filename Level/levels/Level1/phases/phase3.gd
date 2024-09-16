extends Dialogue

@onready var player: CharacterBody2D = %Player
@onready var camera: Camera2D = $"../../Camera2D2"
@onready var game_screen: CanvasLayer = %GameScreen
@onready var goblin_spawn_position: Marker2D = $"../../GoblinSpawnPosition"
@onready var goblin = preload("res://Characters/Goblins/BomberGoblin/goblin.tscn")
@onready var enemy_health_bar = preload("res://Assets/HealthBar/enemy_health_bar.tscn")

var surviving_commoner
var battle: bool = false
var skip_with_mouse_btn: bool = false
var conversation: bool = true
var is_player: bool
var conversaton_line_no
var i: int = 0


func on_input(_event) -> void:
	if _event is InputEventKey and _event.pressed:
		if game_screen.narrating:
			if game_screen.narration_text == "Go and defeat the goblin":
				i += 1
				get_directions(i)

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
		if game_screen.narrating:
			if _event.button_index == MOUSE_BUTTON_LEFT and skip_with_mouse_btn:
				i += 1
				skip_with_mouse_btn = false
				get_directions(i)

	

func enter() -> void:
	surviving_commoner = $"../../Commoner"
	player.can_move = false
	game_screen.narrating = true
	conversaton_line_no = conversation_lines.size()
	get_conversation_line(0)


func get_conversation_line(index: int) -> void:
	var tween: Tween = get_tree().create_tween()
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
			camera.transition_from(goblin_spawn_position.global_position)
		game_screen.narration_text = conversation_line
		game_screen.key_direction = "Enter or Space key"
	else:
		player.can_move = true
		tween.tween_property(surviving_commoner, "modulate", Color8(255, 255, 255), 0.1)
		get_directions(0)


func get_directions(index: int) -> void:
	var direction_line: String = directions[index]["Message"]
	var direction: String = directions[index]["Direction"]
	skip_with_mouse_btn = (direction == "Left mouse button")
	game_screen.narration_text = direction_line
	game_screen.key_direction = direction

	if direction_line == "":
		game_screen.narrating = false
		conversation = false
		battle = true


func spawn_goblin() -> void:
	var goblin_instance: CharacterBody2D = goblin.instantiate() as CharacterBody2D
	goblin_instance.global_position = goblin_spawn_position.global_position
	goblin_instance.add_child(enemy_health_bar.instantiate())
	get_parent().get_parent().add_child(goblin_instance)


func exit() -> void:
	player.can_move = true
	goblin_spawn_position.queue_free()
	get_node("../..").child_exiting_tree.disconnect(_on_level_1_child_exiting_tree)
	game_screen.narrating = false


func _on_level_1_child_exiting_tree(node):
	if node.name == "Goblin":
		transition.emit("Phase4")
