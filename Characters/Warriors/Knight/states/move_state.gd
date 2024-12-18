extends NodeState
@export var character_body_2d: CharacterBody2D;
@export var animated_sprite_2d: AnimatedSprite2D;

@onready var knight = $"../..";

var speed: int = 9930;


func enter() -> void:
	animated_sprite_2d.play("move")
	knight.shot_by_player.connect(
		func (): 
			speed -= 600;
			get_tree().create_timer(3.0).timeout.connect(func (): speed = 9930)
	)


func on_physics_process(delta: float) -> void:
	if knight.destination:
		if knight.destination.x < character_body_2d.global_position.x:
			animated_sprite_2d.flip_h = true;
		else: 
			animated_sprite_2d.flip_h = false;

		character_body_2d.velocity = (knight.destination - character_body_2d.global_position).normalized() * speed * delta;

	character_body_2d.move_and_slide();


func exit() -> void:
	animated_sprite_2d.stop();
