extends CharacterBody2D
@onready var spawn_effect: PackedScene = preload("res://Assets/effects/spawn_effect.tscn")

var level: String
var cause_of_death: String
var spawn_effects: Array[Node] = []


# func _ready() -> void:
# 	get_parent().child_entered_tree.connect(add_to_spawn_effects)
# 	visible = true
# 	var spawn_effect_instance: AnimatedSprite2D = spawn_effect.instantiate()
# 	spawn_effect_instance.animation_finished.connect(make_visible)
# 	spawn_effect_instance.global_position = global_position
# 	get_parent().add_child(spawn_effect_instance)


# func make_visible() -> void:
# 	visible = true
# 	for effect in spawn_effects:
# 		effect.queue_free()


# func add_to_spawn_effects(node: Node) -> void:
# 	if node is SpawnEffect:
		# spawn_effects.append(node)
