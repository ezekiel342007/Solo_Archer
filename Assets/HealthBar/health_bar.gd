extends ProgressBar

@export var max_health: int


func _ready() -> void:
	max_value = max_health


func _physics_process(_delta: float) -> void:
	if get_parent().health != null:
		value = get_parent().health
