extends CharacterBody2D
class_name Knight;

@export var target: CharacterBody2D;
@export var state_machine: NodeFiniteStateMachine;

@onready var upward_view: Node2D = $UpwardView;
@onready var damage_timer: Timer = $DamageTimer;
@onready var forward_view: Node2D = $ForwardView;
@onready var backward_view: Node2D = $BackwardView;
@onready var downward_view: Node2D = $DownwardView;
@onready var destination_finder: Area2D = $DestinationFinder;

signal shot_by_player;
signal hit_target(body: CharacterBody2D, damage: int);

var health: int = 10
var destination: Node2D;
var speed: float = 9930.0;
var attacking: bool = false;
var randm: RandomNumberGenerator = RandomNumberGenerator.new();


func _ready() -> void:
	randm.randomize();


func march_to(new_position: Node2D) -> void:
	destination = new_position;
	state_machine.transition_to("MoveState");


func _physics_process(_delta: float) -> void:
	if upward_view.sense_target:
		state_machine.transition_to("UpAttackState");

	if forward_view.sense_target:
		state_machine.transition_to("StraightAttackRightState");

	if downward_view.sense_target:
		state_machine.transition_to("DownAttackState");

	if backward_view.sense_target:
		state_machine.transition_to("StraightAttackLeftState");

	if target and (upward_view.sense_target == false) and (backward_view.sense_target == false) and (forward_view.sense_target == false) and (downward_view.sense_target == false):
		march_to(target);


func march_randomly_to(new_position: Node2D) -> void:
	var new_point: Vector2 = Vector2(
		randm.randfn(
			randm.randf_range(new_position.global_position.x + randm.randfn(20.0), new_position.global_position.x - randm.randfn(20.0)),
			12.23
		),
		randm.randfn(
			randm.randf_range(
				new_position.global_position.y + randm.randfn(20.0), new_position.global_position.y - randm.randfn(20.0)
			),
			10.23
		)
	);
	var new_destination_marker: Area2D = DestinationMarker.new();
	new_destination_marker.global_position = new_point;
	get_node("../../").add_child(new_destination_marker);
	march_to(new_destination_marker);


func _on_hurt_box_body_entered(body: Arrow) -> void:
	if body.is_in_group("Arrow"):
		shot_by_player.emit();
		body.queue_free();


func _on_destination_finder_area_entered(area: Area2D) -> void:
	if area == destination:
		state_machine.transition_to("IdleState");


func _on_destination_finder_body_entered(body: Node2D) -> void:
	if body == destination:
		state_machine.transition_to("IdleState");
