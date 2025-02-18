extends Path2D;

@export var speed: int = 120;
@export var target_position: Vector2;

@onready var animated_sprite_2d = $"AnimatedSprite2D";
@onready var explosion: Resource = preload("res://Assets/effects/explosion/explosion.tscn");

var target: CharacterBody2D;
var direction: float = 1.0;
var directin_to_target: Vector2;


func _ready() -> void:
	# directin_to_target = target.global_position - global_position;
	curve.set_point_out(0, Vector2(target_position.x / 2, -abs(target_position.x)));
	if animated_sprite_2d.material and animated_sprite_2d.material is ShaderMaterial:
		animated_sprite_2d.material.set_shader_parameter("direction", direction);


func _physics_process(delta: float):
	# velocity = directin_to_target * speed * delta;
	# move_and_slide();


func detonate() -> void:
	var explosion_instance = explosion.instantiate();
	explosion_instance.global_position = global_position;
	explosion_instance.damage = 3;
	get_tree().get_root().call_deferred("add_child", explosion_instance);
	queue_free();


func _on_trigger_body_entered(_body: Node2D):
	detonate();
