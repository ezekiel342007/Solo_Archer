extends CharacterBody2D
class_name Knight;

@export var state_machine: NodeFiniteStateMachine;

@onready var up_attack_area: Area2D = $UpAttackArea
@onready var down_attack_area: Area2D = $DownAttackArea
@onready var straight_attack_area: Area2D = $StraightAttackArea

signal shot_by_player;

var health: int = 10;
var destination: Vector2;
var attacking: bool = false;
var target: CharacterBody2D;


func march_to(new_position: Vector2) -> void:
	destination = new_position;
	state_machine.transition_to("MoveState");


func enter() -> void:
	pass


func _physics_process(_delta: float) -> void:
	if abs(destination - global_position) < Vector2(5.0, 5.0) and attacking == false:
		state_machine.transition_to("IdleState");

	if target:
		march_to(target.global_position);

	
func _on_hurt_box_body_entered(body: Arrow) -> void:
	if body.is_in_group("Arrow"):
		shot_by_player.emit();
		body.queue_free()


func _on_down_attack_area_body_entered(body: Node2D) -> void:
	if body == target and attacking:
		attacking = true
		state_machine.transition_to("DownAttackState")


func _on_straight_attack_area_body_entered(body: Node2D) -> void:
	if body == target and attacking:
		attacking = true
		state_machine.transition_to("StraightAttackState")


func _on_up_attack_area_body_entered(body: Node2D) -> void:
	if body == target and attacking:
		attacking = true
		state_machine.transition_to("UpAttackState")
