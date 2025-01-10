extends Node2D

@onready var knight: Knight = $"../";

var ray_casts: Array[RayCast2D];
var sense_target: bool;

func _ready() -> void:
	ray_casts.append(get_node("RayCast2D"));
	ray_casts.append(get_node("RayCast2D2"));
	ray_casts.append(get_node("RayCast2D3"));
	for ray_cast in ray_casts:
		ray_cast.add_exception(knight);


func _physics_process(_delta: float) -> void:
	if knight.target:
		for ray_cast in ray_casts:
			if ray_cast.get_collider_rid() == knight.target.get_rid():
				sense_target = true;
			else:
				sense_target = false;
