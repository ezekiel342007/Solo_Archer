extends Path2D;

@export var speed: int = 120;
@export var target_position: Vector2;

@onready var path_follow = $PathFollow2D;
@onready var animated_sprite_2d = $"PathFollow2D/AnimatedSprite2D";
@onready var explosion: Resource = preload("res://Assets/effects/explosion/explosion.tscn");

var direction: float = 1.0;
var target: CharacterBody2D;
var directin_to_target: Vector2;


func _ready() -> void:
	# directin_to_target = target.global_position - global_position;
	curve.set_point_out(0, Vector2(target_position.x / 2, - abs(target_position.x)));
	curve.set_point_position(1, target_position);

	if animated_sprite_2d.material and animated_sprite_2d.material is ShaderMaterial:
		animated_sprite_2d.material.set_shader_parameter("direction", direction);


func _process(delta: float):
	if not target_position:
		return;

	if path_follow.progress_ratio >= 0.98:
		queue_free();

	path_follow.progress += speed * delta;
	


func detonate() -> void:
	var explosion_instance = explosion.instantiate();
	explosion_instance.global_position = animated_sprite_2d.global_position;
	explosion_instance.damage = 3;
	get_tree().get_root().call_deferred("add_child", explosion_instance);
	queue_free();


func _on_trigger_body_entered(_body: Node2D):
	detonate();
