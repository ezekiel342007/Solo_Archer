extends CharacterBody2D
class_name BomberGoblin

@export var state_machine: NodeFiniteStateMachine
@export var speed: float = 30.0
@export var patrol_points: Node
@export var health: int = 10

# Indicates how long the player stays in the idle state before transtitioning to the move state
@onready var idle_timer: Timer = %IdleTimer
@onready var player_detector: Area2D = %PlayerDetect
signal has_died

var flip: bool
var can_attack: bool = false
var direction: Vector2


func _physics_process(_delta: float) -> void:
	if health == 0:
		has_died.emit()
		death()


# Detects a player and transition to the attack state
func _on_player_detect_body_entered(body: CharacterBody2D):
	# if the body is the player
	if body.name == "Player" and can_attack:
		state_machine.transition_to("AttackState")


# When player is out of range transition to the idle state
func _on_player_detect_body_exited(body: CharacterBody2D):
	# if the body is the player
	if body.name == "Player":
		# Starts the idle timer
		idle_timer.start()
		state_machine.transition_to("IdleState")


# Switching to the move state
func _on_idle_timer_timeout():
	# Check if there is no player in range to avoid terminating the attack state
	if player_detector.get_overlapping_bodies().size() == 0:
		state_machine.transition_to("MoveState")


# Transitions to the idle state for a while
func _on_point_detect_area_2d_area_entered(area: Area2D):
	# Check if the body is a patrol point
	if area.is_in_group("PatrolPoint"):
		idle_timer.start()
		state_machine.transition_to("IdleState")


func _on_hurt_box_body_entered(body: CharacterBody2D):
	if body.is_in_group("Arrow"):
		modulate = Color8(255, 57, 66)
		health -= 2
		body.queue_free()
	modulate = Color8(255, 255, 255)


func death():
	queue_free()
