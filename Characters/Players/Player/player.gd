extends CharacterBody2D
class_name Player

@export var state_machine: NodeFiniteStateMachine;

@onready var animated_sprite_2d = $AnimatedSprite2D;

var in_pain: bool = false;
var can_move: bool = true;
var aiming: bool = true;


func take_damage(): 
	in_pain = true;
	animated_sprite_2d.material.set_shader_parameter(&"in_pain", in_pain);
	await get_tree().create_timer(0.2).timeout;
	in_pain = false;
	animated_sprite_2d.material.set_shader_parameter(&"in_pain", in_pain);
# func _process(_delta: float) -> void:
# 	animated_sprite_2d.material.set_shader_parameter(&"in_pain", in_pain);
