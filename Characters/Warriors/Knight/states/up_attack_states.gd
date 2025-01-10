extends NodeState

@export var character_body_2d: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D

@onready var knight: Knight = $"../..";


func enter() -> void:
	knight.damage_timer.timeout.connect(handle_damage);
	animated_sprite_2d.play("attack_up");
	knight.damage_timer.start();


func handle_damage(): 
	if knight.target is Player:
		PlayerManagement.health -= 1;
	else:
		knight.hit_target.emit(knight.target, 4);


func exit() -> void:
	animated_sprite_2d.stop();
	knight.damage_timer.stop();
	knight.damage_timer.timeout.disconnect(handle_damage);
	knight.attacking = false
