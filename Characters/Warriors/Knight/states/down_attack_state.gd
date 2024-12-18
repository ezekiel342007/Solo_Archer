extends NodeState
@export var character_body_2d: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D

@onready var knight: Knight = $"../..";


func enter() -> void:
	animated_sprite_2d.play("attack_down");
	print("attack");
	if knight.target is Player:
		PlayerManagement.health -= 4;
	transition.emit("IdleState");


func exit() -> void:
	animated_sprite_2d.stop()
	knight.attacking = false
