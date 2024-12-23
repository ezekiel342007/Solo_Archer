extends CharacterBody2D
class_name Knight;

@export var state_machine: NodeFiniteStateMachine;

@onready var up_attack_area: Area2D = $UpAttackArea
@onready var down_attack_area: Area2D = $DownAttackArea
@onready var straight_attack_area: Area2D = $StraightAttackArea

signal shot_by_player;
# signal hit_target(body: CharacterBody2D);

var health: int = 10;
var destination: Node2D;
var speed: float = 9930.0;
var attacking: bool = false;
var target: CharacterBody2D;


func march_to(new_position: Node2D) -> void:
	destination = new_position;
	state_machine.transition_to("MoveState");


func march_randomly_to(new_position: Node2D) -> void:
	var distance: float = global_position.distance_to(new_position.global_position);
	var travel_time: float = distance/speed;
	get_tree().create_timer(
			randf_range(travel_time - 0.9, travel_time + 0.9)
		).timeout.connect(func (): state_machine.transition_to("IdleState"))


func _on_hurt_box_body_entered(body: Arrow) -> void:
	if body.is_in_group("Arrow"):
		shot_by_player.emit();
		body.queue_free();


func _on_down_attack_area_body_entered(body: CharacterBody2D) -> void:
	if body == target:
		attacking = true;
		state_machine.transition_to("DownAttackState");


func _on_straight_attack_area_body_entered(body: CharacterBody2D) -> void:
	if body == target:
		attacking = true;
		state_machine.transition_to("StraightAttackState");


func _on_up_attack_area_body_entered(body: CharacterBody2D) -> void:
	if body == target:
		attacking = true;
		state_machine.transition_to("UpAttackState");


func _on_destination_finder_body_entered(body: Node2D) -> void:
	if body == destination:
		state_machine.transition_to("IdleState");
