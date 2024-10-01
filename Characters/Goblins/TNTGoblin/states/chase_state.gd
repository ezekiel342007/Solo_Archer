extends NodeState
@export var character_body_2d: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var speed: int = 5500

@onready var level: String = $"../../".level

var player: Node2D


func enter() -> void:
	animated_sprite_2d.play("move")
	player = get_tree().get_root().get_node("/root/" + level + "/Player")


func on_physics_process(delta: float) -> void:
	if player != null:
		var direction: Vector2 = character_body_2d.global_position.direction_to(player.global_position)
		character_body_2d.velocity = direction * speed * delta
		if player.global_position.x < character_body_2d.global_position.x:
			animated_sprite_2d.flip_h = true
		elif player.global_position.x > character_body_2d.global_position.x:
			animated_sprite_2d.flip_h = false
	else:
		character_body_2d.velocity = Vector2(0.0, 0.0)

	character_body_2d.move_and_slide()


func exit() -> void:
	animated_sprite_2d.stop()
